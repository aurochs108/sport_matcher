import 'package:sport_matcher/data/auth/mapper/auth_tokens_mapper.dart';
import 'package:sport_matcher/data/auth/network/api/auth_api.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';
import 'package:sport_matcher/data/auth/repository/auth_repository.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/device_id/repository/abstract_device_id_repository.dart';
import 'package:sport_matcher/data/device_id/repository/device_id_repository.dart';

class SignUpScreenModel {
  final AuthApi _authApi;
  final AbstractDeviceIdRepository _deviceIdRepository;
  final AbstractAuthRepository _authRepository;
  final AuthTokensMapper _authTokensMapper;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
    AbstractDeviceIdRepository? deviceIdRepository,
    AbstractAuthRepository? authRepository,
    AuthTokensMapper? authTokensMapper,
  }) : _authApi = authApi ?? AuthApi(),
       _deviceIdRepository = deviceIdRepository ?? DeviceIdRepository(),
       _authRepository = authRepository ?? AuthRepository(),
       _authTokensMapper = authTokensMapper ?? AuthTokensMapper();

  Future<void> register(String email, String password) async {
    errorMessage = null;
    final deviceId = await _deviceIdRepository.getDeviceId();
    final result = await _authApi.registerWithEmail(
      email: email,
      password: password,
      deviceId: deviceId,
    );

    switch (result) {
      case ApiSuccess(:final data):
        final tokens = _authTokensMapper.responseToDomain(data);
        await _authRepository.saveTokens(tokens);
      case ApiError(:final message, :final code):
        errorMessage = code == 'EMAIL_ALREADY_REGISTERED'
            ? 'This email is already in use. Please use a different email.'
            : message;
    }
  }
}

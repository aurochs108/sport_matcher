import 'package:sport_matcher/data/auth/mapper/auth_mapper.dart';
import 'package:sport_matcher/data/auth/network/api/auth_api.dart';
import 'package:sport_matcher/data/auth/network/request/email_registration_request.dart';
import 'package:sport_matcher/data/auth/repository/abstract_auth_repository.dart';
import 'package:sport_matcher/data/auth/repository/auth_repository.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/abstract_device_id_provider.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/device_id_provider.dart';

class SignUpScreenModel {
  final AuthApi _authApi;
  final AbstractDeviceIdProvider _deviceIdProvider;
  final AbstractAuthRepository _authRepository;
  final AuthMapper _authMapper;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
    AbstractDeviceIdProvider? deviceIdProvider,
    AbstractAuthRepository? authRepository,
    AuthMapper? authMapper,
  })  : _authApi = authApi ?? AuthApi(),
        _deviceIdProvider = deviceIdProvider ?? DeviceIdProvider(),
        _authRepository = authRepository ?? AuthRepository(),
        _authMapper = authMapper ?? AuthMapper();

  Future<void> register(String email, String password) async {
    errorMessage = null;
    final deviceId = await _deviceIdProvider.getDeviceId();
    final result = await _authApi.register(
      EmailRegistrationRequest(email: email, password: password, deviceId: deviceId),
    );

    switch (result) {
      case ApiSuccess(:final data):
        final tokens = _authMapper.responseToDomain(data);
        await _authRepository.saveTokens(tokens);
      case ApiError(:final message, :final code):
        errorMessage = code == 'EMAIL_ALREADY_REGISTERED'
            ? 'This email is already in use. Please use a different email.'
            : message;
    }
  }
}

import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/data/auth/persistence/abstract_token_storage.dart';
import 'package:sport_matcher/data/auth/persistence/token_storage.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/api_result.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/abstract_device_id_provider.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/device_id_provider.dart';

class SignUpScreenModel {
  final AuthApi _authApi;
  final AbstractDeviceIdProvider _deviceIdProvider;
  final AbstractTokenStorage _tokenStorage;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
    AbstractDeviceIdProvider? deviceIdProvider,
    AbstractTokenStorage? tokenStorage,
  })  : _authApi = authApi ?? AuthApi(),
        _deviceIdProvider = deviceIdProvider ?? DeviceIdProvider(),
        _tokenStorage = tokenStorage ?? TokenStorage();

  Future<void> register(String email, String password) async {
    errorMessage = null;
    final deviceId = await _deviceIdProvider.getDeviceId();
    final result = await _authApi.register(
      EmailRegistrationRequest(email: email, password: password, deviceId: deviceId),
    );

    switch (result) {
      case ApiSuccess(:final data):
        await _tokenStorage.saveTokens(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
        );
      case ApiError(:final message):
        errorMessage = message;
    }
  }
}

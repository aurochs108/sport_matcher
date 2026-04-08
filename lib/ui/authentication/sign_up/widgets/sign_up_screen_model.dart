import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/api_result.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/abstract_device_id_provider.dart';
import 'package:sport_matcher/ui/core/utilities/device_id/device_id_provider.dart';

class SignUpScreenModel {
  final AuthApi _authApi;
  final AbstractDeviceIdProvider _deviceIdProvider;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
    AbstractDeviceIdProvider? deviceIdProvider,
  })  : _authApi = authApi ?? AuthApi(),
        _deviceIdProvider = deviceIdProvider ?? DeviceIdProvider();

  Future<void> register(String email, String password) async {
    errorMessage = null;
    final deviceId = await _deviceIdProvider.getDeviceId();
    final result = await _authApi.register(
      EmailRegistrationRequest(email: email, password: password, deviceId: deviceId),
    );

    switch (result) {
      case ApiSuccess():
        break;
      case ApiError(:final message):
        errorMessage = message;
    }
  }
}

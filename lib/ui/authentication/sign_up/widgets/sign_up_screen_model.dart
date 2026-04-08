import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/data/network/api_result.dart';

class SignUpScreenModel {
  final AuthApi _authApi;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
  }) : _authApi = authApi ?? AuthApi();

  Future<void> register(String email, String password) async {
    errorMessage = null;
    final result = await _authApi.register(
      EmailRegistrationRequest(email: email, password: password),
    );

    switch (result) {
      case ApiSuccess():
        break;
      case ApiError(:final message):
        errorMessage = message;
    }
  }
}

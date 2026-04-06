import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';

class SignInScreenModel {
  final AuthApi _authApi;

  String? errorMessage;

  SignInScreenModel({AuthApi? authApi}) : _authApi = authApi ?? AuthApi();

  Future<void> register(String email, String password) async {
    try {
      errorMessage = null;
      await _authApi.register(
        EmailRegistrationRequest(email: email, password: password),
      );
    } catch (e) {
      errorMessage = 'Registration failed: $e';
    }
  }
}

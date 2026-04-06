import 'package:sport_matcher/data/auth/network/auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/ui/core/utilities/error_to_user_message_mapper.dart';

class SignUpScreenModel {
  final AuthApi _authApi;
  final ErrorToUserMessageMapper _errorMapper;

  String? errorMessage;

  SignUpScreenModel({
    AuthApi? authApi,
    ErrorToUserMessageMapper? errorMapper,
  })  : _authApi = authApi ?? AuthApi(),
        _errorMapper = errorMapper ?? ErrorToUserMessageMapper();

  Future<void> register(String email, String password) async {
    try {
      errorMessage = null;
      await _authApi.register(
        EmailRegistrationRequest(email: email, password: password),
      );
    } catch (e) {
      errorMessage = _errorMapper.map(e);
    }
  }
}

import 'package:sport_matcher/data/auth/domain/auth_response.dart';
import 'package:sport_matcher/data/auth/domain/email_registration_request.dart';

abstract class AbstractAuthApi {
  Future<AuthResponse> register(EmailRegistrationRequest request);
}

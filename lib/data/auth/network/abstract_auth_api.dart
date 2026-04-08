import 'package:sport_matcher/data/auth/domain/auth_response.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/api_result.dart';

abstract class AbstractAuthApi {
  Future<ApiResult<AuthResponse>> register(EmailRegistrationRequest request);
}

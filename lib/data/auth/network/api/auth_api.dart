import 'package:sport_matcher/data/auth/network/response/auth_response.dart';
import 'package:sport_matcher/data/auth/network/api/abstract_auth_api.dart';
import 'package:sport_matcher/data/auth/network/request/email_registration_request.dart';
import 'package:sport_matcher/data/core/api_request/api_request.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/core/api_request/http_method.dart';

class AuthApi extends AbstractAuthApi {
  @override
  Future<ApiResult<AuthResponse>> register(EmailRegistrationRequest request) {
    return ApiRequest<AuthResponse>(
      path: '/auth/register/email',
      method: HttpMethod.post,
      fromJson: AuthResponse.fromJson,
      bodyBuilder: () => request.toJson(),
    ).execute();
  }
}

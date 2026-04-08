import 'package:sport_matcher/data/auth/domain/auth_response.dart';
import 'package:sport_matcher/data/auth/network/abstract_auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/data/network/api_request.dart';
import 'package:sport_matcher/data/network/api_result.dart';
import 'package:sport_matcher/data/network/http_method.dart';

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

import 'package:sport_matcher/data/auth/network/response/auth_response.dart';
import 'package:sport_matcher/data/auth/network/api/abstract_auth_api.dart';
import 'package:sport_matcher/data/auth/network/request/email_registration_request.dart';
import 'package:sport_matcher/data/core/api_request/api_request.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/core/api_request/http_method.dart';

class AuthApi implements AbstractAuthApi {
  @override
  Future<ApiResult<AuthResponse>> registerWithEmail({
    required String email,
    required String password,
    required String deviceId,
  }) {
    final request = EmailRegistrationRequest(
      email: email,
      password: password,
      deviceId: deviceId,
    );
    return ApiRequest<AuthResponse>(
      path: '/auth/register/email',
      method: HttpMethod.post,
      responseParser: AuthResponse.fromJson,
      body: request.toJson(),
    ).execute();
  }
}

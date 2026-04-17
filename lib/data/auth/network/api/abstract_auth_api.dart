import 'package:sport_matcher/data/auth/network/response/auth_response.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';

abstract class AbstractAuthApi {
  Future<ApiResult<AuthResponse>> registerWithEmail({
    required String email,
    required String password,
    required String deviceId,
  });
}

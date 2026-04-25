import 'package:sport_matcher/data/core/api_request/api_result.dart';

abstract class AbstractAuthRepository {
  Future<ApiResult<void>> registerWithEmail({
    required String email,
    required String password,
  });
}

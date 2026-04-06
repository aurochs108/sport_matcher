import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_matcher/config/api_config.dart';
import 'package:sport_matcher/data/auth/domain/auth_response.dart';
import 'package:sport_matcher/data/auth/network/abstract_auth_api.dart';
import 'package:sport_matcher/data/auth/network/email_registration_request.dart';
import 'package:sport_matcher/data/network/api_exception.dart';
import 'package:sport_matcher/data/network/error_response.dart';

class AuthApi extends AbstractAuthApi {
  final http.Client _client;

  AuthApi({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<AuthResponse> register(EmailRegistrationRequest request) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/register/email');
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    }

    ErrorResponse? errorResponse;
    try {
      errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
    } catch (_) {}

    throw ApiException(
      statusCode: response.statusCode,
      errorResponse: errorResponse,
    );
  }
}

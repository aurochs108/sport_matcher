import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sport_matcher/config/api_config.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/api_exception.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/api_result.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/error_response.dart';
import 'package:sport_matcher/ui/core/utilities/api_request/http_method.dart';
import 'package:sport_matcher/ui/core/utilities/mapper/api_error_to_user_message_mapper.dart';
import 'package:sport_matcher/ui/core/utilities/mapper/api_error_to_user_message_mapper_impl.dart';

class ApiRequest<TResponse> {
  final String path;
  final HttpMethod method;
  final Map<String, dynamic> Function()? bodyBuilder;
  final TResponse Function(Map<String, dynamic>) fromJson;
  final Duration timeout;
  final http.Client _client;
  final AbstractApiErrorToUserMessageMapper _errorMapper;

  ApiRequest({
    required this.path,
    required this.method,
    required this.fromJson,
    this.bodyBuilder,
    this.timeout = const Duration(seconds: 30),
    http.Client? client,
    AbstractApiErrorToUserMessageMapper? errorMapper,
  })  : _client = client ?? http.Client(),
        _errorMapper = errorMapper ?? ApiErrorToUserMessageMapper();

  Future<ApiResult<TResponse>> execute() async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$path');
      final response = await switch (method) {
        HttpMethod.post => _client.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: bodyBuilder != null ? jsonEncode(bodyBuilder!()) : null,
          ),
      }.timeout(timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiSuccess(fromJson(jsonDecode(response.body)));
      }

      ErrorResponse? errorResponse;
      try {
        errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
      } catch (_) {}

      return ApiError(await _errorMapper.map(ApiException(
        statusCode: response.statusCode,
        errorResponse: errorResponse,
      )));
    } catch (e) {
      return ApiError(await _errorMapper.map(e));
    }
  }
}

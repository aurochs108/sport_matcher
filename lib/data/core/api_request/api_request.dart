import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:sport_matcher/config/api_config.dart';
import 'package:sport_matcher/data/core/api_request/api_exception.dart';
import 'package:sport_matcher/data/core/api_request/api_result.dart';
import 'package:sport_matcher/data/core/api_request/error_response.dart';
import 'package:sport_matcher/data/core/api_request/http_method.dart';
import 'package:sport_matcher/data/core/mapper/abstract_api_error_to_user_message_mapper.dart';
import 'package:sport_matcher/data/core/mapper/api_error_to_user_message_mapper.dart';

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
      final headers = {
        'Content-Type': 'application/json',
      };
      final response = await switch (method) {
        HttpMethod.post => _client.post(
            url,
            headers: headers,
            body: bodyBuilder != null ? jsonEncode(bodyBuilder!()) : null,
          ),
      }.timeout(timeout);

      debugPrint('ApiRequest [$path] ${response.statusCode}: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          return ApiSuccess(fromJson(jsonDecode(response.body)));
        } catch (e, stackTrace) {
          debugPrint('ApiRequest deserialization error: $e');
          debugPrint('StackTrace: $stackTrace');
          return ApiError(await _errorMapper.map(e));
        }
      }

      ErrorResponse? errorResponse;
      try {
        errorResponse = ErrorResponse.fromJson(jsonDecode(response.body));
      } catch (_) {}

      return ApiError(await _errorMapper.map(ApiException(
        statusCode: response.statusCode,
        errorResponse: errorResponse,
      )));
    } catch (e, stackTrace) {
      debugPrint('ApiRequest error: $e');
      debugPrint('StackTrace: $stackTrace');
      return ApiError(await _errorMapper.map(e));
    }
  }
}

import 'package:sport_matcher/data/core/api_request/error_response.dart';

class ApiException implements Exception {
  final int statusCode;
  final ErrorResponse? errorResponse;

  ApiException({required this.statusCode, this.errorResponse});

  @override
  String toString() => 'ApiException($statusCode, ${errorResponse?.code})';
}

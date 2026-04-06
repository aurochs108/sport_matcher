import 'dart:io';

import 'package:sport_matcher/data/network/api_exception.dart';

class ErrorToUserMessageMapper {
  static const _apiErrorMessages = {
    'EMAIL_ALREADY_EXISTS': 'An account with this email already exists.',
    'INVALID_EMAIL': 'Please enter a valid email address.',
    'WEAK_PASSWORD': 'Password is too weak. Please choose a stronger one.',
    'INVALID_CREDENTIALS': 'Incorrect email or password.',
    'ACCOUNT_LOCKED': 'Your account has been locked. Please try again later.',
    'ACCOUNT_DISABLED': 'Your account has been disabled.',
    'TOKEN_EXPIRED': 'Your session has expired. Please sign in again.',
    'RATE_LIMIT_EXCEEDED': 'Too many attempts. Please try again later.',
  };

  static const _httpStatusMessages = {
    400: 'Invalid request. Please check your input.',
    401: 'Unauthorized. Please sign in again.',
    403: 'You don\'t have permission to perform this action.',
    404: 'The requested resource was not found.',
    408: 'Request timed out. Please try again.',
    409: 'A conflict occurred. Please try again.',
    422: 'Invalid data. Please check your input.',
    429: 'Too many requests. Please try again later.',
    500: 'Something went wrong on our end. Please try again later.',
    502: 'Server is temporarily unavailable. Please try again later.',
    503: 'Service is currently unavailable. Please try again later.',
  };

  String map(Object error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network.';
    }

    if (error is HttpException) {
      return 'A network error occurred. Please try again.';
    }

    if (error is ApiException) {
      final code = error.errorResponse?.code;
      if (code != null && _apiErrorMessages.containsKey(code)) {
        return _apiErrorMessages[code]!;
      }
      if (_httpStatusMessages.containsKey(error.statusCode)) {
        return _httpStatusMessages[error.statusCode]!;
      }
      return 'Something went wrong. Please try again.';
    }

    return 'An unexpected error occurred. Please try again.';
  }
}

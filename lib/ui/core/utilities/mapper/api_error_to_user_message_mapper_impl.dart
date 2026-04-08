import 'dart:async';
import 'dart:io';

import 'package:sport_matcher/data/network/abstract_internet_connection_checker.dart';
import 'package:sport_matcher/data/network/api_exception.dart';
import 'package:sport_matcher/data/network/internet_connection_checker.dart';
import 'package:sport_matcher/ui/core/utilities/mapper/api_error_to_user_message_mapper.dart';

class ApiErrorToUserMessageMapper implements AbstractApiErrorToUserMessageMapper {
  final AbstractInternetConnectionChecker _connectionChecker;

  ApiErrorToUserMessageMapper({
    AbstractInternetConnectionChecker? connectionChecker,
  }) : _connectionChecker = connectionChecker ?? InternetConnectionChecker();
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

  @override
  Future<String> map(Object error) async {
    if (error is TimeoutException) {
      return 'Request timed out. Please try again.';
    }

    if (error is SocketException) {
      if (!await _connectionChecker.hasConnection()) {
        return 'No internet connection. Please check your network.';
      }
      return 'Unable to connect to the server. Please try again later.';
    }

    if (error is HttpException) {
      return 'A network error occurred. Please try again.';
    }

    if (error is ApiException) {
      if (_httpStatusMessages.containsKey(error.statusCode)) {
        return _httpStatusMessages[error.statusCode]!;
      }
      return 'Something went wrong. Please try again.';
    }

    return 'An unexpected error occurred. Please try again.';
  }
}

import 'dart:io';

import 'package:sport_matcher/data/network/abstract_internet_connection_checker.dart';

class InternetConnectionChecker implements AbstractInternetConnectionChecker {
  @override
  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}

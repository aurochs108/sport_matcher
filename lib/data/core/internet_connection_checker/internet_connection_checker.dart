import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sport_matcher/data/core/internet_connection_checker/abstract_internet_connection_checker.dart';

class InternetConnectionChecker implements AbstractInternetConnectionChecker {
  final Connectivity _connectivity;

  InternetConnectionChecker({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  @override
  Future<bool> hasConnection() async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}

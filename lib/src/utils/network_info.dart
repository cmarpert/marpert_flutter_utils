import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _networkChecker;
  NetworkInfo({Connectivity? networkChecker}) : _networkChecker = networkChecker ?? Connectivity();

  Future<bool> get isConnected async {
    ConnectivityResult connectivityResult = ConnectivityResult.none;
    connectivityResult = await _networkChecker.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

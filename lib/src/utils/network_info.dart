import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:marpert_utils/marpert_utils.dart';

/// class provides a single instance of NetworkInfo,
/// providing connectivity status through the
/// getter [isConnected]
///
/// The NetworkInfo class currently uses uses the connectivity_plus package
/// to determine connectivity status
class NetworkInfo implements INetworkInfo {
  final Connectivity networkChecker;

  // private constructor, class cannot be instantiated, only through static getter
  NetworkInfo._({required this.networkChecker});

  // for testing -> inject mockNetworkChecker
  @visibleForTesting
  static NetworkInfo instanceForTesting({required Connectivity networkChecker}) {
    return NetworkInfo._(networkChecker: networkChecker);
  }

  // for normal use
  static NetworkInfo get instance {
    final networkCheckerInstance = Connectivity();
    return NetworkInfo._(networkChecker: networkCheckerInstance);
  }

  @override
  Future<bool> get isConnected async {
    //ConnectivityResult connectivityResult = ConnectivityResult.none;
    final connectivityResult = await networkChecker.checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> isDeviceConnected() async {
  // Check network connectivity (WiFi / mobile)
  final connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult == ConnectivityResult.none) {
    return false; // no network at all
  }

  // Check actual internet access (e.g., Google reachable)
  final hasInternet =
      await InternetConnectionChecker.createInstance().hasConnection;
  return hasInternet;
}

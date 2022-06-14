import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplWithConnectionChecker implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImplWithConnectionChecker({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

class NetworkInfoImplWithAnyPackage implements NetworkInfo {
  @override
  Future<bool> get isConnected => throw UnimplementedError();
}

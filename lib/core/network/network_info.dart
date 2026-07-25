// lib/services/network_info.dart

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionController =
      StreamController<bool>.broadcast();

  bool _isConnected = true;

  NetworkInfo({required Connectivity connectivity})
      : _connectivity = connectivity {
    _init();
  }

  void _init() {
    _connectivity.onConnectivityChanged.listen((results) {
      final connected = results.any(
        (r) => r != ConnectivityResult.none,
      );
      _isConnected = connected;
      _connectionController.add(connected);
    });
  }

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    _isConnected = results.any((r) => r != ConnectivityResult.none);
    return _isConnected;
  }

  bool get isConnectedSync => _isConnected;

  Stream<bool> get onConnectionChanged => _connectionController.stream;

  void dispose() {
    _connectionController.close();
  }
}
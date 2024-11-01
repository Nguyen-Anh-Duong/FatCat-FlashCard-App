import 'dart:io';

import 'package:FatCat/services/connectivity_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class GroupViewModel extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  GroupViewModel() {
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  Future<void> _checkInitialConnectivity() async {
    final results = await _connectivityService.checkConnectivity();
    await _updateConnectionStatus(results);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    final hasNetworkConnection = results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi);

    if (hasNetworkConnection) {
      try {
        // Thử kết nối đến một địa chỉ internet để kiểm tra
        final response = await InternetAddress.lookup('google.com');
        _isConnected = response.isNotEmpty && response[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        _isConnected = false;
      }
    } else {
      _isConnected = false;
    }

    notifyListeners();
  }

  void _listenToConnectivityChanges() {
    _connectivityService.connectivityStream.listen(_updateConnectionStatus);
  }
}

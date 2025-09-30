import 'package:flutter/material.dart';

class UserDataModel extends ChangeNotifier {
  bool _isLoading = false;
  String _data = '';
  String _error = '';

  bool get isLoading => _isLoading;
  String get data => _data;
  String get error => _error;
  bool get hasError => _error.isNotEmpty;

  Future<void> fetchUserData() async {
    _isLoading = true;
    _error = '';
    _data = '';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _data = 'User: John Doe\nEmail: john.doe@example.com\nRole: Administrator';
    _isLoading = false;
    notifyListeners();
  }

  void clearData() {
    _data = '';
    _error = '';
    notifyListeners();
  }
}

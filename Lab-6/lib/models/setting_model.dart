import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  bool _notificationsEnabled = true;
  double _volumeLevel = 50.0;

  bool get notificationsEnabled => _notificationsEnabled;
  double get volumeLevel => _volumeLevel;

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void setVolumeLevel(double value) {
    _volumeLevel = value;
    notifyListeners();
  }

  void resetToDefaults() {
    _notificationsEnabled = true;
    _volumeLevel = 50.0;
    notifyListeners();
  }
}

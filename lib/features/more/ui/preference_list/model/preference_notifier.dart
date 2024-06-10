import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceNotifier extends ChangeNotifier {
  static const String _preferenceKey = 'isPreferenceSaved';
  bool _isPreferenceSaved = false;

  bool get isPreferenceSaved => _isPreferenceSaved;

  PreferenceNotifier() {
    loadPreference();
  }

  Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isPreferenceSaved = prefs.getBool(_preferenceKey) ?? false;
    notifyListeners();
  }

  Future<void> setPreferenceSaved(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isPreferenceSaved = value;
    await prefs.setBool(_preferenceKey, value);
    notifyListeners();
  }

  Future<void> removePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isPreferenceSaved = false;
    await prefs.remove(_preferenceKey);
    notifyListeners();
  }
}

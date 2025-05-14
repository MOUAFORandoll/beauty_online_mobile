import 'dart:async';
import 'dart:convert';

import 'package:beauty/common/models/professional.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:potatoes_secured_preferences/potatoes_secured_preferences.dart';
import 'package:beauty/common/bloc/user_cubit.dart';
import 'package:beauty/common/models/user.dart';

class PreferencesService extends SecuredPreferencesService {
  static const String _keyUser = 'user';
  static const String _keyPro = 'professional';
  static const String _keyUserUID = 'user_id';
  static const String _keyDeviceToken = 'device-token';
  static const String _keyAuthToken = 'auth_token';
  static const String _keyThemeMode = 'theme_mode';
  PreferencesService(
    super.preferences,
    super.secureStorage,
    this.packageInfo,
  );
  final PackageInfo packageInfo;

  User? get user {
    final value = preferences.getString(_keyUser);

    if (value == null) return null;
    return User.fromJson(jsonDecode(value) as Map<String, dynamic>);
  }

  Future<void> saveUser(User user) {
    return Future.wait([
      preferences.setString(_keyUserUID, user.id),
      preferences.setString(_keyUser, jsonEncode(user)),
    ]);
  }

  Professional? get professional {
    final value = preferences.getString(_keyPro);

    if (value == null) return null;
    return Professional.fromJson(jsonDecode(value) as Map<String, dynamic>);
  }

  Future<void> saveProfessional(Professional professional) {
    return Future.wait([
      preferences.setString(_keyPro, jsonEncode(professional)),
    ]);
  }

  Future<void> saveDeviceToken(String token) {
    return secureStorage.write(key: _keyDeviceToken, value: token);
  }

  Future<String?> get deviceToken {
    return secureStorage.read(key: _keyDeviceToken);
  }

  Future<void> saveAuthToken(String token) {
    return secureStorage.write(key: _keyAuthToken, value: token);
  }

  ThemeMode? get themeMode {
    final value = preferences.getString(_keyThemeMode);

    if (value == null) return null;
    return ThemeMode.values.where((m) => m.name == value).firstOrNull;
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    return preferences.setString(_keyThemeMode, mode.name);
  }

  @override
  FutureOr<Map<String, String>> getAuthHeaders() async {
    final String userId = user!.id;
    final String? authToken = await secureStorage.read(key: _keyAuthToken);
    final DateTime dateTime = DateTime.now();

    if (authToken == null) {
      throw InvalidAuthenticationHeadersException();
    }
    return {'uid': user!.id};
    // return {"authorization": 'Bearer ' + authToken};
  }
}

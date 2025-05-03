import 'package:flutter/material.dart';
import 'package:potatoes/common/bloc/value_cubit.dart';
import 'package:beauty/common/services/preferences_service.dart';

extension ThemeModeExtension on ThemeMode {
  String get settingsName {
    switch (this) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      case ThemeMode.system:
        return 'Par défaut du système';
    }
  }
}

class ThemeModeCubit extends ValueCubit<ThemeMode> {
  final PreferencesService preferencesService;

  ThemeModeCubit(this.preferencesService) : super(ThemeMode.system) {
    final themeMode = preferencesService.themeMode;
    emit(themeMode ?? ThemeMode.system);
  }

  @override
  void set(ThemeMode value) {
    super.set(value);
    preferencesService.saveThemeMode(value);
  }
}

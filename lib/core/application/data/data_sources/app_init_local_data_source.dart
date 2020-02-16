import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vt_live_map/core/application/domain/enums/settings_keys.dart';

abstract class AppInitLocalDataSource {
  static final Locale fallbackLocale = Locale('en', 'US');

  Future<bool> setDefaultLocaleInLocalStorage();

  bool settingAlreadySet(SettingsKeys key);
}

class AppInitLocalDataSourceImpl extends AppInitLocalDataSource {
  final SharedPreferences sharedPreferences;

  AppInitLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> setDefaultLocaleInLocalStorage() async {
    if (settingAlreadySet(SettingsKeys.LOCALE)) {
      return true;
    } else {
      // Todo: check if users locale is supported, if so use that locale instead of fallback.
      return sharedPreferences.setString(
        SettingsKeys.LOCALE.toString(),
        AppInitLocalDataSource.fallbackLocale.toString(),
      );
    }
  }

  @override
  bool settingAlreadySet(SettingsKeys key) {
    dynamic exists = sharedPreferences.get(key.toString());
    if (exists != null) {
      return true;
    } else {
      return false;
    }
  }
}

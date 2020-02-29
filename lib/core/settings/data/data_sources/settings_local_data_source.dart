import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {}

class SettingsLocalDataSourceImpl extends SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({@required this.sharedPreferences});
}

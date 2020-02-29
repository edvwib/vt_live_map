import 'package:vt_live_map/core/settings/domain/repositories/settings_repository.dart';

class ManageSettings {
  final SettingsRepository settingsRepository;

  ManageSettings(this.settingsRepository);

  Future<dynamic> get(
    final String key, {
    final Type asType,
  }) async {
    return await settingsRepository.getSetting(
      key,
      asType: asType,
    );
  }

  Future<dynamic> setSetting(
    final String key,
    final dynamic value, {
    final Type asType,
  }) async {
    return await settingsRepository.setSetting(
      key,
      value,
      asType: asType,
    );
  }
}

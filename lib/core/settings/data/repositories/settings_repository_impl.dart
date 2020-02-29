import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/core/settings/data/data_sources/settings_local_data_source.dart';
import 'package:vt_live_map/core/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsLocalDataSource settingsLocalDataSource;

  SettingsRepositoryImpl({
    @required this.settingsLocalDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> getSetting(
    final String key, {
    final Type asType,
  }) {
    // TODO: implement getSetting
    return null;
  }

  @override
  Future<Either<Failure, dynamic>> setSetting(
    final String key,
    final value, {
    final Type asType,
  }) {
    // TODO: implement setSetting
    return null;
  }
}

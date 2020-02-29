import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, dynamic>> getSetting(
    final String key, {
    final Type asType,
  });

  Future<Either<Failure, dynamic>> setSetting(
    final String key,
    final dynamic value, {
    final Type asType,
  });
}

import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/error/failure.dart';

abstract class AppInitRepository {
  Future<Either<Failure, void>> setDefaultLocale();
}

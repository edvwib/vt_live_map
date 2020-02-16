import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/application/domain/repositories/app_init_repository.dart';
import 'package:vt_live_map/core/error/failure.dart';

class SetDefaults {
  final AppInitRepository appInitRepository;

  SetDefaults(this.appInitRepository);

  Future<Either<Failure, bool>> call() async {
    try {
      await setDefaultLocale();
      return Right(true);
    } catch (e) {
      return Left(CachedFailure());
    }
  }

  Future<void> setDefaultLocale() async {
    return await appInitRepository.setDefaultLocale();
  }
}

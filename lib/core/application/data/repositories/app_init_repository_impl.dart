import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/application/data/data_sources/app_init_local_data_source.dart';
import 'package:vt_live_map/core/application/domain/repositories/app_init_repository.dart';
import 'package:vt_live_map/core/error/failure.dart';

class AppInitRepositoryImpl extends AppInitRepository {
  final AppInitLocalDataSource appInitLocalDataSource;

  AppInitRepositoryImpl({
    @required this.appInitLocalDataSource,
  });

  @override
  Future<Either<Failure, void>> setDefaultLocale() {
    return _setDefault(
      appInitLocalDataSource.setDefaultLocaleInLocalStorage(),
    );
  }

  Future<Either<Failure, bool>> _setDefault(Future<bool> saveFunction) async {
    try {
      bool saved = await saveFunction;
      return saved == true ? Right(saved) : Left(CachedFailure());
    } catch (e) {
      return Left(CachedFailure());
    }
  }
}

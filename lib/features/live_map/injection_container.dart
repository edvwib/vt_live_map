import 'package:get_it/get_it.dart';
import 'package:vt_live_map/core/http/get.dart';
import 'package:vt_live_map/features/live_map/domain/use_cases/get_live_map.dart';
import 'package:vt_live_map/features/live_map/presentation/bloc/live_map_bloc.dart';

import 'data/data_sources/live_map_remote_data_source.dart';
import 'data/repositories/live_map_repository_impl.dart';
import 'domain/repositories/live_map_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<LiveMapBloc>(
    () => LiveMapBloc(
      getLiveMap: sl<GetLiveMap>(),
    ),
  );

  sl.registerLazySingleton(
    () => GetLiveMap(
      repository: sl<LiveMapRepository>(),
    ),
  );

  sl.registerLazySingleton<LiveMapRepository>(
    () => LiveMapRepositoryImpl(
      remoteDataSource: sl<LiveMapRemoteDataSource>(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<LiveMapRemoteDataSource>(
    () => LiveMapRemoteDataSourceImpl(
      sl<Get>(),
    ),
  );

  sl.registerLazySingleton<Get>(
    () => Get(),
  );
}

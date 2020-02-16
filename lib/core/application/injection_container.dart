import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vt_live_map/core/application/domain/repositories/app_init_repository.dart';
import 'package:vt_live_map/core/application/domain/use_cases/set_defaults.dart';
import 'package:vt_live_map/core/application/presentation/bloc/init_bloc.dart';

import 'data/data_sources/app_init_local_data_source.dart';
import 'data/repositories/app_init_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => SetDefaults(
        sl<AppInitRepository>(),
      ));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );

  sl.registerLazySingleton<AppInitLocalDataSource>(
    () => AppInitLocalDataSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  sl.registerLazySingleton<AppInitRepository>(() => AppInitRepositoryImpl(
        appInitLocalDataSource: sl(),
      ));
  sl.registerFactory(() => InitBloc(
        setDefaults: sl<SetDefaults>(),
      ));
}

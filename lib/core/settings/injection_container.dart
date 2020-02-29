import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vt_live_map/core/settings/domain/repositories/settings_repository.dart';
import 'package:vt_live_map/core/settings/domain/use_cases/manage_settings.dart';
import 'package:vt_live_map/core/settings/presentation/bloc/settings_bloc.dart';

import 'data/data_sources/settings_local_data_source.dart';
import 'data/repositories/settings_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => ManageSettings(
        sl<SettingsRepository>(),
      ));

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(
      sharedPreferences: sl<SharedPreferences>(),
    ),
  );

  sl.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(
        settingsLocalDataSource: sl<SettingsLocalDataSource>(),
      ));
  sl.registerLazySingleton(() => SettingsBloc(
        manageSettings: sl<ManageSettings>(),
      ));
}

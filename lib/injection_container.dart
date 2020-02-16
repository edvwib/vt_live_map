import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:vt_live_map/core/application/injection_container.dart'
    as app_init_di;
import 'package:vt_live_map/core/authentication/injection_container.dart'
    as authentication_di;
import 'package:vt_live_map/features/live_map/injection_container.dart'
    as live_map_di;

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );

  await app_init_di.init();
  await authentication_di.init();
  await live_map_di.init();
}

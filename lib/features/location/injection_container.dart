import 'package:get_it/get_it.dart';
import 'package:vt_live_map/core/http/get.dart';
import 'package:vt_live_map/features/location/data/data_sources/nearby_remote_data_source.dart';
import 'package:vt_live_map/features/location/data/repositories/nearby_repository_impl.dart';
import 'package:vt_live_map/features/location/domain/repositories/nearby_repository.dart';
import 'package:vt_live_map/features/location/domain/use_cases/get_nearby.dart';
import 'package:vt_live_map/features/location/presentation/bloc/nearby_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<NearbyBloc>(
    () => NearbyBloc(
      getNearby: sl<GetNearby>(),
    ),
  );

  sl.registerLazySingleton(
    () => GetNearby(
      repository: sl<NearbyRepository>(),
    ),
  );

  sl.registerLazySingleton<NearbyRepository>(
    () => NearbyRepositoryImpl(
      remoteDataSource: sl<NearbyRemoteDataSource>(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<NearbyRemoteDataSource>(
    () => NearbyRemoteDataSourceImpl(
      sl<Get>(),
    ),
  );
}

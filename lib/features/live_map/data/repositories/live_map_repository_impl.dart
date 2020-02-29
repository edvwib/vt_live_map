import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/core/network/network_info.dart';
import 'package:vt_live_map/features/live_map/data/data_sources/live_map_remote_data_source.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_model.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/data/models/vehicle_model.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';
import 'package:vt_live_map/features/live_map/domain/repositories/live_map_repository.dart';

class LiveMapRepositoryImpl extends LiveMapRepository {
  final LiveMapRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LiveMapRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, LiveMapModel>> getLiveMap(
    final LiveMapRequestModel request, {
    final List<ProdClass> vehicleTypeFilter = const [],
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final LiveMapModel response =
            await remoteDataSource.getLiveMap(request);

        if (vehicleTypeFilter.isEmpty) {
          return Right(response);
        }

        final List<String> parsedVehicleTypeFilter = vehicleTypeFilter
            .map((final ProdClass pc) => getProdClassValue(pc).toLowerCase())
            .toList();

        final List<VehicleModel> filteredVehicles = response.vehicles
            .where(
              (final VehicleModel v) =>
                  parsedVehicleTypeFilter.contains((v.prodClass).toLowerCase()),
            )
            .toList();

        final filteredResponse = LiveMapModel(
          filteredVehicles,
          response.minx,
          response.maxx,
          response.miny,
          response.maxy,
        );

        return Right(filteredResponse);
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

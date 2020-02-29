import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/core/network/network_info.dart';
import 'package:vt_live_map/features/location/data/data_sources/nearby_remote_data_source.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';
import 'package:vt_live_map/features/location/domain/repositories/nearby_repository.dart';

class NearbyRepositoryImpl extends NearbyRepository {
  final NearbyRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NearbyRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  Future<Either<Failure, NearbyStops>> getNearbyStops(
    final NearbyStopsRequestModel request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final NearbyStops response =
            await remoteDataSource.getNearbyStops(request);

        return Right(response);
      } on Exception catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

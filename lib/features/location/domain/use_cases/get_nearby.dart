import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';
import 'package:vt_live_map/features/location/domain/repositories/nearby_repository.dart';

class GetNearby {
  final NearbyRepository repository;

  GetNearby({
    @required this.repository,
  });

  Future<Either<Failure, NearbyStops>> stops(
    final NearbyStopsRequestModel request,
  ) async {
    return await repository.getNearbyStops(request);
  }
}

import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';

abstract class NearbyRepository {
  Future<Either<Failure, NearbyStops>> getNearbyStops(
    final NearbyStopsRequestModel request,
  );
}

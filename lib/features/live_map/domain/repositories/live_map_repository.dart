import 'package:dartz/dartz.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';

abstract class LiveMapRepository {
  Future<Either<Failure, LiveMap>> getLiveMap(
    final LiveMapRequestModel request, {
    final List<ProdClass> vehicleTypeFilter = const [],
  });
}

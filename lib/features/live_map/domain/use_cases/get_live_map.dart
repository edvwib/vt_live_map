import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';
import 'package:vt_live_map/features/live_map/domain/repositories/live_map_repository.dart';

class GetLiveMap {
  final LiveMapRepository repository;

  GetLiveMap({
    @required this.repository,
  });

  Future<Either<Failure, LiveMap>> call(
    final LiveMapRequestModel request, {
    final List<ProdClass> vehicleTypeFilter = const [],
  }) async {
    return await repository.getLiveMap(
      request,
      vehicleTypeFilter: vehicleTypeFilter,
    );
  }
}

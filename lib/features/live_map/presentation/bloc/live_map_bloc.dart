import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/error/failure.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';
import 'package:vt_live_map/features/live_map/domain/use_cases/get_live_map.dart';

part 'live_map_event.dart';
part 'live_map_state.dart';

class LiveMapBloc extends Bloc<LiveMapEvent, LiveMapState> {
  final GetLiveMap getLiveMap;

  LiveMapBloc({
    @required this.getLiveMap,
  }) : assert(getLiveMap != null);

  @override
  LiveMapState get initialState => Empty();

  @override
  Stream<LiveMapState> mapEventToState(LiveMapEvent event) async* {
    if (event is GetLiveMapEvent) {
      yield Loading();
      final result = await getLiveMap(
        event.request,
        vehicleTypeFilter: event.vehicleTypeFilter,
      );
      yield* _getOrFail(result);
    }
  }

  Stream<LiveMapState> _getOrFail(Either<Failure, LiveMap> result) async* {
    yield result.fold(
      (final failure) => Error(failure.toString()),
      (final liveMap) => Loaded(liveMap),
    );
  }
}

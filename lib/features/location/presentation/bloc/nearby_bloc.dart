import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';
import 'package:vt_live_map/features/location/domain/use_cases/get_nearby.dart';

part 'nearby_event.dart';
part 'nearby_state.dart';

class NearbyBloc extends Bloc<NearbyEvent, NearbyState> {
  final GetNearby getNearby;

  NearbyBloc({
    @required this.getNearby,
  }) : assert(getNearby != null);

  @override
  NearbyState get initialState => Empty();

  @override
  Stream<NearbyState> mapEventToState(NearbyEvent event) async* {
    if (event is GetNearbyStopsEvent) {
      yield Loading();
      final result = await getNearby.stops(event.request);
      yield result.fold(
        (final failure) => Error(failure.toString()),
        (final nearbyStops) => LoadedNearbyStops(nearbyStops),
      );
    }
  }
}

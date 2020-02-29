import 'package:equatable/equatable.dart';
import 'package:vt_live_map/features/location/domain/entities/coord.dart';
import 'package:vt_live_map/features/location/domain/entities/stop.dart';

class NearbyStops extends Equatable {
  final List<Stop> stops;
  final List<Coord> coords;
  final String errorMessage;
  final String error;
  final DateTime serverDateTime;

  NearbyStops({
    this.stops,
    this.coords,
    this.errorMessage,
    this.error,
    this.serverDateTime,
  });

  @override
  List<Object> get props => [
        this.stops,
        this.coords,
        this.errorMessage,
        this.error,
        this.serverDateTime,
      ];
}

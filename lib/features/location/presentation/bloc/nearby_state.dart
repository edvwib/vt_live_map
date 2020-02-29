part of 'nearby_bloc.dart';

@immutable
abstract class NearbyState extends Equatable {
  final List<dynamic> properties;

  NearbyState([this.properties]);

  @override
  List<Object> get props => properties;
}

class Empty extends NearbyState {}

class Loading extends NearbyState {}

class LoadedNearbyStops extends NearbyState {
  final NearbyStops nearbyStops;

  LoadedNearbyStops(
    this.nearbyStops,
  ) : super([
          nearbyStops,
        ]);
}

class Error extends NearbyState {
  final String error;

  Error(
    this.error,
  ) : super([
          error,
        ]);
}

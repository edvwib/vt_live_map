part of 'live_map_bloc.dart';

@immutable
abstract class LiveMapState extends Equatable {
  final List<dynamic> properties;

  LiveMapState([this.properties]);

  @override
  List<Object> get props => properties;
}

class Empty extends LiveMapState {}

class Loading extends LiveMapState {}

class Loaded extends LiveMapState {
  final LiveMap liveMap;

  Loaded(
    this.liveMap,
  ) : super([
          liveMap,
        ]);
}

class Error extends LiveMapState {
  final String error;

  Error(
    this.error,
  ) : super([
          error,
        ]);
}

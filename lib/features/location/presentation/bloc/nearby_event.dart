part of 'nearby_bloc.dart';

@immutable
abstract class NearbyEvent extends Equatable {
  final List<dynamic> properties;

  NearbyEvent(this.properties) : super();

  @override
  List<Object> get props => properties;
}

class GetNearbyStopsEvent extends NearbyEvent {
  final NearbyStopsRequestModel request;

  GetNearbyStopsEvent(
    this.request,
  ) : super([
          request,
        ]);
}

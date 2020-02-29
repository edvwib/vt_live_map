part of 'live_map_bloc.dart';

@immutable
abstract class LiveMapEvent extends Equatable {
  final List<dynamic> properties;

  LiveMapEvent(this.properties) : super();

  @override
  List<Object> get props => properties;
}

class GetLiveMapEvent extends LiveMapEvent {
  final LiveMapRequestModel request;
  final List<ProdClass> vehicleTypeFilter;

  GetLiveMapEvent(
    this.request, {
    this.vehicleTypeFilter = const [],
  }) : super([
          request,
          vehicleTypeFilter,
        ]);
}

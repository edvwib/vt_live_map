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

  GetLiveMapEvent(
    this.request,
  ) : super([
          request,
        ]);
}

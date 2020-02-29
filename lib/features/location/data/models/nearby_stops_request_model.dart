import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'nearby_stops_request_model.g.dart';

@JsonSerializable(
  createFactory: false,
)
class NearbyStopsRequestModel extends Equatable {
  final double longitude;
  final double latitude;
  final int maximumNumberOfStops;
  final int maxDistance;

  NearbyStopsRequestModel({
    @required this.longitude,
    @required this.latitude,
    this.maximumNumberOfStops,
    this.maxDistance,
  });

  @override
  List<Object> get props => [
        this.longitude,
        this.latitude,
        this.maximumNumberOfStops,
        this.maxDistance,
      ];

  Map<String, dynamic> toJson() => _$NearbyStopsRequestModelToJson(this);
}

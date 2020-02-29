import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/core/helpers/location.dart';
import 'package:vt_live_map/features/location/domain/entities/stop.dart';

part 'stop_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class StopModel extends Stop {
  final String id;
  @JsonKey(fromJson: WGS84fromString)
  final double lon;
  final String idx;
  final String weight;
  final String name;
  final String track;
  @JsonKey(fromJson: WGS84fromString)
  final double lat;

  StopModel(
    this.id,
    this.lon,
    this.idx,
    this.weight,
    this.name,
    this.track,
    this.lat,
  ) : super(
          id: id,
          longitude: lon,
          idx: idx,
          weight: weight,
          name: name,
          track: track,
          latitude: lat,
        );

  factory StopModel.fromJson(Map<String, dynamic> json) =>
      _$StopModelFromJson(json);
}

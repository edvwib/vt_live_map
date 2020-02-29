import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/core/helpers/location.dart';
import 'package:vt_live_map/features/location/domain/entities/coord.dart';

part 'coord_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class CoordModel extends Coord {
  @JsonKey(fromJson: WGS84fromString)
  final double lon;
  final String idx;
  final String name;
  final String type;
  @JsonKey(fromJson: WGS84fromString)
  final double lat;

  CoordModel(
    this.lon,
    this.idx,
    this.name,
    this.type,
    this.lat,
  ) : super(
          longitude: lon,
          idx: idx,
          name: name,
          type: type,
          latitude: lat,
        );

  factory CoordModel.fromJson(Map<String, dynamic> json) =>
      _$CoordModelFromJson(json);
}

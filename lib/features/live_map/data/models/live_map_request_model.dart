import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/helpers/location.dart';

part 'live_map_request_model.g.dart';

@JsonSerializable(
  createFactory: false,
)
class LiveMapRequestModel extends Equatable {
  /// The minimum latitude on the X axis
  @JsonKey(toJson: WGS84toAPI)
  final double minX;

  /// The maximum latitude on the X axis
  @JsonKey(toJson: WGS84toAPI)
  final double maxX;

  /// The minimum latitude on the Y axis
  @JsonKey(toJson: WGS84toAPI)
  final double minY;

  /// The maximum latitude on the Y axis
  @JsonKey(toJson: WGS84toAPI)
  final double maxY;

  /// Whether the response should only include vehicles that are position based
  /// on GPS. Defaults to `false`
  final bool onlyRealtime;

  LiveMapRequestModel({
    @required this.minX,
    @required this.maxX,
    @required this.minY,
    @required this.maxY,
    this.onlyRealtime = false,
  });

  @override
  List<Object> get props => [
        this.minX,
        this.maxX,
        this.minY,
        this.maxY,
        this.onlyRealtime,
      ];

  Map<String, dynamic> toJson() => _$LiveMapRequestModelToJson(this);
}

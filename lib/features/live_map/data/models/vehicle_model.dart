import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/core/helpers/hexColor.dart';
import 'package:vt_live_map/core/helpers/location.dart';
import 'package:vt_live_map/features/live_map/domain/entities/vehicle.dart';

part 'vehicle_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class VehicleModel extends Vehicle {
  @JsonKey(fromJson: _colorStringToColor)
  final Color lcolor;

  @JsonKey(fromJson: _colorStringToColor)
  final Color bcolor;

  @JsonKey(name: 'prodclass')
  final String prodClass;

  @JsonKey(fromJson: _parseDirection)
  final double direction;

  @JsonKey(fromJson: _parseDelay)
  final int delay;

  @JsonKey(fromJson: WGS84fromAPI)
  final double x;

  @JsonKey(fromJson: WGS84fromAPI)
  final double y;

  VehicleModel(
    this.lcolor,
    this.bcolor,
    this.prodClass,
    this.direction,
    final String name,
    final String gid,
    this.delay,
    this.x,
    this.y,
  ) : super(
          lineColor: lcolor,
          backgroundColor: bcolor,
          vehicleType: prodClass,
          direction: direction,
          name: name,
          gid: gid,
          delay: delay,
          x: x,
          y: y,
        );

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);

  static Color _colorStringToColor(final String color) => HexColor(color);

  static double _parseDirection(final String vector) =>
      90 - (int.parse(vector) * 11.25);

  static int _parseDelay(final String value) {
    if (value == null) return null;
    return int.tryParse(value);
  }
}

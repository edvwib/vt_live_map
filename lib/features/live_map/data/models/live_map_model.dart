import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/core/helpers/location.dart';
import 'package:vt_live_map/features/live_map/data/models/vehicle_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';

part 'live_map_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
)
class LiveMapModel extends LiveMap {
  final List<VehicleModel> vehicles;

  @JsonKey(fromJson: WGS84fromAPI)
  final double minx;

  @JsonKey(fromJson: WGS84fromAPI)
  final double maxx;

  @JsonKey(fromJson: WGS84fromAPI)
  final double miny;

  @JsonKey(fromJson: WGS84fromAPI)
  final double maxy;

  LiveMapModel(
    this.vehicles,
    this.minx,
    this.maxx,
    this.miny,
    this.maxy,
  ) : super(
          vehicles: vehicles,
          minX: minx,
          maxX: maxx,
          minY: miny,
          maxY: maxy,
        );

  @override
  List<Object> get props => [
        this.vehicles,
        this.minx,
        this.maxx,
        this.miny,
        this.maxy,
      ];

  factory LiveMapModel.fromJson(Map<String, dynamic> json) =>
      _$LiveMapModelFromJson(json['livemap']);
}

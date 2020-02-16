import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:vt_live_map/core/lang/lang.dart';
import 'package:vt_live_map/features/live_map/domain/entities/vehicle_icon.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';

class Vehicle extends Equatable {
  /// Line color of the journey.
  final Color lineColor;

  /// Background color of the journey.
  final Color backgroundColor;

  final String vehicleType;

  /// Direction of the vehicle.
  final double direction;

  /// Journey name.
  final String name;

  /// Service GID.
  final String gid;

  /// Current delay of the vehicle in minutes, can be negative, zero or positive.
  final int delay;

  /// X coordinate (longitude) of the position in WGS84
  final double x;

  /// Y coordinate (latitude) of the position in WGS84
  final double y;

  Vehicle({
    @required this.lineColor,
    @required this.backgroundColor,
    @required this.vehicleType,
    @required this.direction,
    @required this.name,
    @required this.gid,
    @required this.delay,
    @required this.x,
    @required this.y,
  });

  @override
  List<Object> get props => [
        this.lineColor,
        this.backgroundColor,
        this.vehicleType,
        this.direction,
        this.name,
        this.gid,
        this.delay,
        this.x,
        this.y,
      ];

  Future<BitmapDescriptor> getIcon() async {
    return await VehicleIcon.create(this);
  }

  String getTranslatedVehicleType() {
    return '';
  }

  String getLine() {
    String line = name;
    if (this.vehicleType == getProdClassValue(ProdClass.TRAM))
      line = line.replaceFirst('Spå ', '');
    if (this.vehicleType == getProdClassValue(ProdClass.BUS)) {
      /*if (name == 'Flygbussarna')
        line = line.replaceFirst('Flygbussarna', '✈');
      else*/
      line = line.replaceFirst('Bus ', '');
    }

    return line.trim();
  }

  String getName() {
    if (this.vehicleType == getProdClassValue(ProdClass.TRAM))
      return name.replaceFirst('Spå', translate(Lang.VEHICLE_TYPE_TRAM));
    if (this.vehicleType == getProdClassValue(ProdClass.BUS))
      return name.replaceFirst('Bus', translate(Lang.VEHICLE_TYPE_BUS));

    return name;
  }

  String getDelayString() {
    if (delay == null) return translate(Lang.VEHICLE_DELAY_NO_DATA);

    String lang;

    if (delay < -1)
      lang = Lang.VEHICLE_DELAY_EARLY_PLURAL;
    else if (delay == -1)
      lang = Lang.VEHICLE_DELAY_EARLY_SINGULAR;
    else if (delay == 0)
      lang = Lang.VEHICLE_DELAY_ON_TIME;
    else if (delay == 1)
      lang = Lang.VEHICLE_DELAY_DELAYED_SINGULAR;
    else
      lang = Lang.VEHICLE_DELAY_DELAYED_PLURAL;

    return translate(lang).replaceFirst('%s', delay.abs().toString());
  }
}

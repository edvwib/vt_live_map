import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vt_live_map/vt/helpers/hexColor.dart';
import 'package:vt_live_map/vt/vehicles/ProdClass.dart';
import 'package:vt_live_map/vt/vehicles/icon.dart' as VehicleIcon;

class Vehicle {
  double x;
  double y;
  String name;
  String gid;
  Color lColor;
  Color bColor;
  int direction;
  double get rotation {
    return 90 - (direction * 11.25);
  }

  ProdClass prodClass;
  String get prodClassString {
    return getDecodedProdClass(prodClass);
  }

  int delay;
  String get delayString {
    if (delay == null) return 'Ingen realtidsdata finns';
    if (delay > 0) return '${delay}m sen';
    if (delay == 0) return 'I tid';
    if (delay < 0) return '${delay.abs()}m tidig';

    return '${delay}m';
  }

  Vehicle(this.x, this.y, this.name, this.gid, this.lColor, this.bColor,
      this.direction, this.prodClass, this.delay);

  Future<BitmapDescriptor> getIcon() async {
    return await VehicleIcon.Icon.create(this);
  }

  static String translateName(String name) {
    name = name.replaceAll('Spå', 'Spårvagn');
    name = name.replaceAll('Bus', 'Buss');
    name = name.replaceAll('Tax', 'Taxi');
    name = name.replaceAll('Fär', 'Färja');

    return name;
  }

  String getLine() {
    switch (prodClass) {
      case ProdClass.VAS:
        return name;
      case ProdClass.LDT:
        return name;
      case ProdClass.REG:
        return name;
      case ProdClass.BUS:
        return name.replaceAll('Buss ', '');
      case ProdClass.BOAT:
        return name.replaceAll('Färja ', '');
      case ProdClass.TRAM:
        return name.replaceAll('Spårvagn ', '');
      case ProdClass.TAXI:
        return name.replaceAll('Taxi ', '');
      default:
        return name;
    }
  }

  factory Vehicle.fromJson(final Map<String, dynamic> vehicle) {
    return Vehicle(
      num.tryParse(vehicle['x']).toDouble() / 1000000,
      num.tryParse(vehicle['y']).toDouble() / 1000000,
      translateName(vehicle['name']),
      vehicle['gid'],
      HexColor(vehicle['lcolor']),
      HexColor(vehicle['bcolor']),
      num.tryParse(vehicle['direction']).toInt(),
      getProdClass(vehicle['prodclass']),
      int.tryParse(vehicle.containsKey('delay') ? vehicle['delay'] : ''),
    );
  }

  static List<Vehicle> fromJsonArray(final List<dynamic> vehicles) {
    List<Vehicle> list = [];

    vehicles.forEach((vehicle) => list.add(Vehicle.fromJson(vehicle)));

    return list;
  }
}

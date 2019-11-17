import 'package:vt_live_map/vt/vehicles/vehicle.dart';

class LiveMapResponse {
  final List<Vehicle> vehicles;
  final String time;
  final int minX;
  final int maxX;
  final int minY;
  final int maxY;

  LiveMapResponse(
      this.vehicles, this.time, this.minX, this.maxX, this.minY, this.maxY);

  factory LiveMapResponse.fromJson(Map<String, dynamic> json) {
    final liveMap = json['livemap'];
    return LiveMapResponse(
      Vehicle.fromJsonArray(liveMap['vehicles']),
      liveMap['time'],
      liveMap['minX'],
      liveMap['maxX'],
      liveMap['minY'],
      liveMap['maxY'],
    );
  }
}

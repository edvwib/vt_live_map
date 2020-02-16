import 'package:equatable/equatable.dart';
import 'package:vt_live_map/features/live_map/data/models/vehicle_model.dart';

class LiveMap extends Equatable {
  /// List of vehicles inside the bounding box.
  final List<VehicleModel> vehicles;

  /// Left border (longitude) of the bounding box in WGS84
  final double minX;

  /// Right border (longitude) of the bounding box in WGS84
  final double maxX;

  /// Lower border (latitude) of the bounding box in WGS84
  final double minY;

  /// Upper border (latitude) of the bounding box in WGS84
  final double maxY;

  LiveMap({
    this.vehicles,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
  });

  @override
  List<Object> get props => [
        this.vehicles,
        this.minX,
        this.maxX,
        this.minY,
        this.maxY,
      ];
}

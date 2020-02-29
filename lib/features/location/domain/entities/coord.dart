import 'package:equatable/equatable.dart';

class Coord extends Equatable {
  /// The WGS84 longitude
  final double longitude;

  /// This index can be used to reorder the StopLocations and CoordLocations in JSON format response to their correct order. IN JSON you can receive two arrays, one for Stops and one for Addresses. This attribute is only contained in reponses to the location.name request. The location with idx=1 is the best fitting location.
  final String idx;

  /// Contains the output name of the address or point of interest
  final String name;

  /// The attribute type specifies the type of location. Valid values are ADR (address) or POI (point of interest). This attribute can be used to do some sort of classification in the user interface. For later trip requests it does not have any meaning.
  final String type;

  /// The WGS84 latitude
  final double latitude;

  Coord({
    this.longitude,
    this.idx,
    this.name,
    this.type,
    this.latitude,
  });

  @override
  List<Object> get props => [
        this.longitude,
        this.idx,
        this.name,
        this.type,
        this.latitude,
      ];
}

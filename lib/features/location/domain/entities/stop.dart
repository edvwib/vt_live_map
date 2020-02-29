import 'package:equatable/equatable.dart';

class Stop extends Equatable {
  /// This ID can either be used as originId or destId to perform a trip request or to call a departure board
  final String id;

  /// The WGS84 longitude
  final double longitude;

  /// This index can be used to reorder the StopLocations and CoordLocations in
  /// JSON format response to their correct order. IN JSON you can receive two
  /// arrays, one for Stops and one for Addresses. This attribute is only
  /// contained in reponses to the location.name request. The location with
  /// idx=1 is the best fitting location
  final String idx;

  ///  This value specifies some kind of importance of this stop. The more
  ///  traffic at this stop the higher the weight. The range is between 0 and
  ///  32767. This attribute is just contained in the location.allstops response
  final String weight;

  /// Contains the output name of this stop or station
  final String name;

  /// Track information, if available
  final String track;

  /// The WGS84 latitude
  final double latitude;

  Stop({
    this.id,
    this.longitude,
    this.idx,
    this.weight,
    this.name,
    this.track,
    this.latitude,
  });

  @override
  List<Object> get props => [
        this.id,
        this.longitude,
        this.idx,
        this.weight,
        this.name,
        this.track,
        this.latitude,
      ];
}

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vt_live_map/features/location/data/models/coord_model.dart';
import 'package:vt_live_map/features/location/data/models/stop_model.dart';
import 'package:vt_live_map/features/location/domain/entities/nearby_stops.dart';

part 'nearby_stops_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  createToJson: false,
)
class NearbyStopsModel extends NearbyStops {
  final String errorText;
  final String error;
  @JsonKey(fromJson: _serverDateFromJson)
  final DateTime serverdate;
  @JsonKey(fromJson: _serverTimeFromJson)
  final DateTime servertime;
  final List<StopModel> StopLocation;
  final List<CoordModel> CoordLocation;
  final String noNamespaceSchemaLocation;

  NearbyStopsModel(
    this.errorText,
    this.error,
    this.serverdate,
    this.servertime,
    this.StopLocation,
    this.CoordLocation,
    this.noNamespaceSchemaLocation,
  ) : super(
            errorMessage: errorText,
            error: error,
            stops: StopLocation,
            coords: CoordLocation,
            serverDateTime: serverdate?.add(
              Duration(
                hours: servertime?.hour,
                minutes: servertime?.minute,
              ),
            ));

  factory NearbyStopsModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyStopsModelFromJson(json['LocationList']);

  static _serverDateFromJson(final String value) {
    return null;
    return DateFormat('YYYY-MM-dd').parse(value);
  }

  static _serverTimeFromJson(final String value) {
    return null;
    return DateFormat('HH:mm').parse(value);
  }
}

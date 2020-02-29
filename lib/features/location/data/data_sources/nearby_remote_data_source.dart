import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vt_live_map/core/application/domain/enums/api.dart';
import 'package:vt_live_map/core/http/get.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_model.dart';
import 'package:vt_live_map/features/location/data/models/nearby_stops_request_model.dart';

abstract class NearbyRemoteDataSource {
  Future<NearbyStopsModel> getNearbyStops(
      final NearbyStopsRequestModel request);
}

class NearbyRemoteDataSourceImpl extends NearbyRemoteDataSource {
  final Get get;

  NearbyRemoteDataSourceImpl(
    this.get,
  );

  Future<NearbyStopsModel> getNearbyStops(
      final NearbyStopsRequestModel request) async {
    final Map<String, String> parameters = {};
    parameters['format'] = 'json';
    parameters['originCoordLat'] = (request.latitude).toString();
    parameters['originCoordLong'] = (request.longitude).toString();
    if (request.maximumNumberOfStops != null)
      parameters['maxNo'] = request.maximumNumberOfStops.toString();
    if (request.maxDistance != null)
      parameters['maxDist'] = request.maxDistance.toString();

    final Uri uri = Uri.https(
      Api.baseUrl,
      '${Api.travelUrl}/location.nearbystops',
      parameters,
    );
    final http.Response res = await get(uri);

    if (res.statusCode == 200) {
      return NearbyStopsModel.fromJson(json.decode(res.body));
    } else {
      print(res.statusCode);
      print(res.body);
      throw Exception('Couln\'t fetch nearby stations');
    }
  }
}

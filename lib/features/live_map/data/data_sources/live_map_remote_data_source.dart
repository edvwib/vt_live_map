import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vt_live_map/core/application/domain/enums/api.dart';
import 'package:vt_live_map/core/helpers/location.dart';
import 'package:vt_live_map/core/http/get.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_model.dart';
import 'package:vt_live_map/features/live_map/data/models/live_map_request_model.dart';
import 'package:vt_live_map/features/live_map/domain/entities/live_map.dart';

abstract class LiveMapRemoteDataSource {
  Future<LiveMap> getLiveMap(final LiveMapRequestModel request);
}

class LiveMapRemoteDataSourceImpl extends LiveMapRemoteDataSource {
  final Get get;

  LiveMapRemoteDataSourceImpl(
    this.get,
  );

  Future<LiveMap> getLiveMap(final LiveMapRequestModel request) async {
    final Map<String, String> parameters = {};
    parameters['minx'] = WGS84toAPI(request.minX).toString();
    parameters['maxx'] = WGS84toAPI(request.maxX).toString();
    parameters['miny'] = WGS84toAPI(request.minY).toString();
    parameters['maxy'] = WGS84toAPI(request.maxY).toString();
    parameters['onlyRealtime'] = request.onlyRealtime.toString();

    final Uri uri = Uri.https(
      Api.baseUrl,
      '${Api.travelUrl}/livemap',
      parameters,
    );
    final http.Response res = await get(uri);

    if (res.statusCode == 200) {
      return LiveMapModel.fromJson(json.decode(res.body));
    } else {
      print(res.statusCode);
      print(res.body);
      throw Exception('Couln\'t fetch vehicles');
    }
  }
}

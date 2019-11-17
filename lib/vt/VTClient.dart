import 'dart:async';
import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'auth/authResponse.dart';
import 'vehicles/liveMapResponse.dart';

class VTClient {
  // TODO: Move to env
  final String _baseUrl = 'api.vasttrafik.se';
  final String _authUrl = '/token';
  final String _travelUrl = '/bin/rest.exe/v2';
  final String _token = '';
  AuthResponse _auth;
  DateTime _tokenExpiresAt = DateTime.now();

  VTClient();

  Future<void> getToken() async {
    final Map<String, String> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Authorization'] = 'Basic $_token';

    Map<String, String> body = {};
    body['grant_type'] = 'client_credentials';
    final String deviceId = await DeviceId.getID;
    body['scope'] = 'device_$deviceId';

    http.Response res = await http.post(Uri.https(_baseUrl, _authUrl),
        headers: headers, body: body);

    if (res.statusCode == 200) {
      _auth = AuthResponse.fromJson(json.decode(res.body));
      _tokenExpiresAt =
          DateTime.now().add(Duration(seconds: _auth.expiresIn - 10));
    } else {
      throw Exception('Autentication failed');
    }
  }

  Future<void> checkToken() async {
    if (DateTime.now().isAfter(_tokenExpiresAt)) {
      await getToken();
    }
  }

  Future<http.Response> get(dynamic url, {Map<String, String> headers}) async {
    await checkToken();
    if (headers == null) headers = {};
    headers['Authorization'] = 'Bearer ${_auth.accessToken}';
    return http.get(url, headers: headers);
  }

  Future<LiveMapResponse> liveMap(
      LatLngBounds bounds, bool onlyRealtime) async {
    final String minX = (bounds.southwest.longitude * 1000000).toString();
    final String maxX = (bounds.northeast.longitude * 1000000).toString();
    final String minY = (bounds.southwest.latitude * 1000000).toString();
    final String maxY = (bounds.northeast.latitude * 1000000).toString();

    final Map<String, String> parameters = {};
    parameters['minx'] = minX;
    parameters['maxx'] = maxX;
    parameters['miny'] = minY;
    parameters['maxy'] = maxY;
    parameters['onlyRealtime'] = onlyRealtime.toString();

    final uri = Uri.https(_baseUrl, '$_travelUrl/livemap', parameters);
    final http.Response res = await get(uri);

    if (res.statusCode == 200) {
      return LiveMapResponse.fromJson(json.decode(res.body));
    } else {
      print(res.statusCode);
      print(res.body);
      throw Exception('Couln\'t fetch vehicles');
    }
  }
}

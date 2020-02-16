import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:http/http.dart' as http;
import 'package:vt_live_map/core/application/domain/enums/api.dart';
import 'package:vt_live_map/core/authentication/data/models/auth_model.dart';
import 'package:vt_live_map/core/authentication/domain/entities/auth.dart';

class Token {
  static final String _token =
      'UFdCS0dXcXVFWHBPT2YwQkZEQkRVRnpuaUNBYTpuejZnS3FZbmZVSGZaWDBpQWZGVkhCZmZBcjBh';
  static Auth auth;
  static DateTime tokenExpiresAt = DateTime.now();

  static Future<void> getToken() async {
    final Map<String, String> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Authorization'] = 'Basic $_token';

    Map<String, String> body = {};
    body['grant_type'] = 'client_credentials';
    final String deviceId = await DeviceId.getID;
    body['scope'] = 'device_$deviceId';

    http.Response res = await http.post(Uri.https(Api.baseUrl, Api.authUrl),
        headers: headers, body: body);

    if (res.statusCode == 200) {
      auth = AuthModel.fromJson(json.decode(res.body));
      tokenExpiresAt =
          DateTime.now().add(Duration(seconds: auth.expiresIn - 10));
    } else {
      throw Exception('Autentication failed');
    }
  }

  static Future<void> checkToken() async {
    if (DateTime.now().isAfter(tokenExpiresAt)) {
      await getToken();
    }
  }
}

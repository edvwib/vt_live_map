import 'package:http/http.dart' as http;
import 'package:vt_live_map/core/http/token.dart';

class Get {
  Future<http.Response> call(
    final Uri url, {
    Map<String, String> headers,
  }) async {
    final String token = await Token.checkToken();

    if (headers == null) headers = {};
    headers['Authorization'] = 'Bearer $token';

    return http.get(url, headers: headers);
  }
}

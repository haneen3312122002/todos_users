import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  //res:
  static dynamic _handleResponse(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Request failed (${res.statusCode}): ${res.body}');
    }
  }

  // GET request
  static Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final res = await http.get(Uri.parse(url), headers: headers);
    return _handleResponse(res);
  }

  // POST request
  static Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final res = await http.post(
      Uri.parse(url),
      headers: headers ?? {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(res);
  }
}

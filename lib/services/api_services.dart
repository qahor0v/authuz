import 'dart:convert';

import 'package:authuz/models/user_model.dart';
import 'package:http/http.dart';

class ApiServices {
  static const String base = "localhost:8080";
  static const String loginPath = "/login";
  static const String registerPath = "/register";
  static const Map<String, String> headers = {
    'content-type': 'application/json'
  };

  static Future<String?> registerUser(UserModel user) async {
    final body = jsonEncode(user.toMap());
    Uri uri = Uri.http(base, registerPath);
    final response = await post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    }
    return null;
  }

  static Future<String?> loginUser(UserModel user) async {
    final body = jsonEncode(user.toMap());
    Uri uri = Uri.http(base, loginPath);
    final response = await post(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['token'];
    }
    return null;
  }
}

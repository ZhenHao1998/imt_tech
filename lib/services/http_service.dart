import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final randomUserUrl = 'randomuser.me';
  Future<http.Response?> get({
    Map<String, dynamic>? param,
  }) {
    param?.removeWhere((key, value) => value == '');

    final client = http.Client();

    try {
      return client.get(Uri.https(randomUserUrl, '/api/', param));
    } catch (error) {
      if (kDebugMode) print(error);

      return Future.error(error);
    }
  }
}

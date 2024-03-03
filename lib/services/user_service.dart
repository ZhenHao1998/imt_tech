import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:imt_tech/services/http_service.dart';

class UserService {
  final httpService = GetIt.I<HttpService>();

  Future<Map<String, dynamic>> getUserList() async {
    final param = {'results': '15'};

    return httpService.get(param: param).then((value) {
      final data = jsonDecode(value!.body) as Map<String, dynamic>;

      return data;
    });
  }
}

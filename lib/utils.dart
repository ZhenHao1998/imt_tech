import 'package:get_it/get_it.dart';
import 'package:imt_tech/services/http_service.dart';
import 'package:imt_tech/services/user_service.dart';

String generateFullName({required String firstname, required String lastname}) {
  return '$firstname $lastname';
}

Future<void> bootstrap() async {
  GetIt.I.registerFactory(HttpService.new);
  GetIt.I.registerFactory(UserService.new);

  await GetIt.I.allReady();
}

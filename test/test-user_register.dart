

import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/services/http_services.dart';

Future<void> main() async {

  AuthResponse response = await HttpService.registerUser("name", "email@email.com", "password", "123456789", "address", "44000", "Isld");

  print(response);

}
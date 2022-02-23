import 'package:shirleys/modal/auth.dart';
import 'package:shirleys/services/http_services.dart';

void main()async{

  AuthResponse response = await HttpService.loginUser("test6@gmail.com", "123456");

  print(response);
}
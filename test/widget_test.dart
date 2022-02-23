

import 'package:cached_map/cached_map.dart';
import 'package:shirleys/main.dart';
import 'package:shirleys/services/http_services.dart';

Future<void> main() async {

  HttpService.getReview(2.toString()).then((value) {
    print(value);
  });


}

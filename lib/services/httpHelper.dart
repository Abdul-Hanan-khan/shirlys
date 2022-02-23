import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class HttpHelper {

  static String _url = 'https://shirleysofficial.com/app/app.php';

  static Future<http.Response> post({
    @required dynamic body,
  }) async {
    var response = await  http.post(
      Uri.parse(_url),
      body: body,
    );
    if(response.statusCode==503)
    {
      _url = '';

      return http.post(
        Uri.parse(_url),
        body: body,
      );
    }
    else
      print("response: ${response.body}");
    return response;
  }

  static Future<http.Response> postWithCustomUrl({
    @required dynamic url,
    @required dynamic body,
  }) async {
    return await http.post(
      url,
      body: body,
    );
  }

}
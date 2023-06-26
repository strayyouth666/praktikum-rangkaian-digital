import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartcare_web/system/response.dart';

import 'api.dart';

class LoginDB {
  final String email;
  final String password;

  LoginDB({
    required this.email,
    required this.password,
});
  Future<String> login() async {
    try {
      final response = await http.post(Uri.parse(Api.signInApi), body: {
        "email": email,
        "password": password,

      });
      if(response.statusCode == ResponseDB.successCode){
        final result = json.decode(response.body);
        return result;
      } else {
        return 'Error';
      }
    } catch (e) {
      print(e);
      return 'Error';
    }
  }
}
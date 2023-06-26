import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcare_web/system/api.dart';
import 'package:smartcare_web/system/encrypt_decrypt.dart';

class DatabaseRequest{
  // final String fullName;
  final String password;
  final String email;
  DatabaseRequest({required this.password, required this.email});

  Future <String> request() async{
    try {
      final response = await http.post(
          Uri.parse(Api.api),
      body: {
            // 'fullname': Security(text: fullName).encrypt(),
            'email': Security(text: email).encrypt(),
            'password': Security(text: password).encrypt(),
      });
      if(response.statusCode == 200) {
        final result = json.decode(response.body);
        return result;
      } else {
        return 'Server Error';
      }
    } catch (e){
      return 'Web Error';
    }
  }
}
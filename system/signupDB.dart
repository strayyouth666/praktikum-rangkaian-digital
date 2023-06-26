import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartcare_web/system/api.dart';
import 'package:smartcare_web/system/response.dart';

class RegisterDB{
  late final String name, email, password;
  RegisterDB({
    required this.name,
    required this.password,
    required this.email,
    // required this.upliner,
  });
  
  Future<String> register() async {
    try {
    final response = await http.post(Uri.parse(Api.signUpApi), body: {
      "email": email,
      "fullname": name,
      "password": password,
      // "upliner": upliner,
    });
    if(response.statusCode == ResponseDB.successCode){
      final result = json.decode(response.body);
      return result;
    } else {
      return 'Error';
    }
  } catch (e) {
      return 'Error';
    }
  }
}
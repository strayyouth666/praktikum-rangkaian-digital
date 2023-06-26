// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartcare_web/system/user.dart';

class Services {
  static const ROOT = 'http://localhost/RDIG/rdigg.php';
  static const String _GET_ACTION = 'GET_ALL';
  static const String _CREATE_TABLE = 'CREATE_TABLE';
  static const String _ADD_USER_ACTION = 'ADD_USER';
  static const String _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const String _DELETE_USER_ACTION = 'DELETE_USER';

  static Future<List<User>> getUsers() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _GET_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("getUsers >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<User> list = parsePhotos(response.body);
        return list;
      } else {
        throw <User>[];
      }
    } catch (e) {
      return <User>[];
    }
  }

  static List<User> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<String> createTable() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _CREATE_TABLE;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("createTable >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> addUser(String firstName, String lastName) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _ADD_USER_ACTION;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("addUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> updateUser(
      String userId, String firstName, String lastName) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _UPDATE_USER_ACTION;
      map["user_id"] = userId;
      map["first_name"] = firstName;
      map["last_name"] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }

  static Future<String> deleteUser(String userId) async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _DELETE_USER_ACTION;
      map["user_id"] = userId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("deleteUser >> Response:: ${response.body}");
      return response.body;
    } catch (e) {
      return 'error';
    }
  }
}

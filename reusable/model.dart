import 'package:http/http.dart';

typedef TypeInitiator<T> = T Function();

abstract class Model {
  void fromJson(Map<String, dynamic> data);
  String toJson() => "{}";
}

abstract class MultipleItemsModel<T extends Model> extends Model {
  List<T> list = [];

  T model();

  @override
  void fromJson(Map<String, dynamic> data) {
    if (!(data.containsKey('data') && data['data'] is List<dynamic>)) return;

    final rawData = data['data'] as List<dynamic>;

    list = rawData.map((e) => model()..fromJson(e)).toList();
  }
}

class DefaultJsonModel extends Model {
  Map<String, dynamic>? json;

  @override
  void fromJson(Map<String, dynamic> data) {
    json = data;
  }
}

class RawResponseModel extends Model {
  late Response response;

  @override
  void fromJson(Map<String, dynamic> data) {}
}


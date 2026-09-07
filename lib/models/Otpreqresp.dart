import 'dart:convert';
Otpreqresp otpreqrespFromJson(String str) => Otpreqresp.fromJson(json.decode(str));
String otpreqrespToJson(Otpreqresp data) => json.encode(data.toJson());
class Otpreqresp {
  Otpreqresp({
      this.success, 
      this.data, 
      this.message,});

  Otpreqresp.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }
  bool? success;
  dynamic data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    return map;
  }

}
import 'dart:convert';
Regresp regrespFromJson(String str) => Regresp.fromJson(json.decode(str));
String regrespToJson(Regresp data) => json.encode(data.toJson());
class Regresp {
  Regresp({
      this.success, 
      this.data,});

  Regresp.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.accessToken, 
      this.refreshToken, 
      this.customer,});

  Data.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  String? accessToken;
  String? refreshToken;
  Customer? customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }

}

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());
class Customer {
  Customer({
      this.id, 
      this.phone, 
      this.name, 
      this.email, 
      this.photoUrl,});

  Customer.fromJson(dynamic json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    email = json['email'];
    photoUrl = json['photoUrl'];
  }
  String? id;
  String? phone;
  String? name;
  String? email;
  dynamic photoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phone'] = phone;
    map['name'] = name;
    map['email'] = email;
    map['photoUrl'] = photoUrl;
    return map;
  }

}
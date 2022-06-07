import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) {
  print(str);
  return RegisterResponseModel.fromJson(json.decode(str));
}

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.name,
    required this.email,
    required this.date,
    //required this.ClientpubKey,
    required this.id,
  });
  late final String username;
  late final String name;
  late final String email;
  late final String date;
  //late final List<dynamic> ClientpubKey;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    email = json['email'];
    date = json['date'];
    //ClientpubKey = json['ClientpubKey'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['name'] = name;
    _data['email'] = email;
    _data['date'] = date;
    //_data['ClientpubKey'] = ClientpubKey;
    _data['id'] = id;
    return _data;
  }
}

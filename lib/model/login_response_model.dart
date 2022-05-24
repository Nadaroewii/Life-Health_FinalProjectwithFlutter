import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
});
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data{
  Data({
    required this.username,
    required this.name,
    required this.email,
    required this.date,
    required this.id,
    required this.token,
    required this.ServerpubKey,
    //required this.ClientpubKey,
    //required this.ClientprivKey,
});
  late final String username;
  late final String name;
  late final String email;
  late final String date;
  late final String id;
  late final String token;
  late final List<dynamic> ServerpubKey;
  //late final List<dynamic> ClientpubKey;
  //late final List<dynamic> ClientprivKey;


  Data.fromJson(Map<String, dynamic> json){
    username = json['username'];
    name = json['name'];
    email = json['email'];
    date = json['date'];
    id = json['id'];
    token = json['token'];
    ServerpubKey = json['ServerpubKey'];
    //ClientpubKey = json['ClientpubKey'];
    //ClientprivKey = json['ClientprivKey'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['name'] = name;
    _data['email'] = email;
    _data['date'] = date;
    _data['id'] = id;
    _data['token'] = token;
    _data['ServerpubKey'] = ServerpubKey;
    //_data['ClientpubKey'] = ClientpubKey;
    //_data['ClientprivKey'] = ClientprivKey;
    return _data;
  }
}
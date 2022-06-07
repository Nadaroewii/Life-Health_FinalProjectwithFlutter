import 'dart:convert';
import 'package:flspai/config.dart';
import 'package:flspai/model/ecnrypt_request_model.dart';
import 'package:flspai/model/encrypt_response_model.dart';
import 'package:flspai/model/historydata.dart';
//import 'package:flspai/model/historydata.dart';
import 'package:flspai/model/login_request_model.dart';
import 'package:flspai/model/login_response_model.dart';
import 'package:flspai/model/register_request_model.dart';
import 'package:flspai/model/register_response_model.dart';
import 'package:flspai/services/shared_services.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(Map model) async {
    print(model);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var url = Uri.parse(Config.apiURL + Config.loginAPI);

    var response = await client.post(
      url,
      //Uri.parse(Config.apiURL + Config.loginAPI),
      headers: requestHeaders,
      body: model,
    );

    print(response.body);

    if (response.statusCode == 200) {
      //SHARED
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(Map model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var url = Uri.parse(Config.apiURL + Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: model,
    );

    print(response.body);
    return registerResponseModel(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      //SHARED
      return response.body;
    } else {
      return "";
    }
  }

  Future getEncrypt(
      List<String> duration,
      List<String> distance,
      List<String> dataactv,
      List<String> kal,
      List<String> lastlatitude,
      List<String> lastlongitude) async {
    try {
      var loginDetails = await SharedService.loginDetails();
      final responsedata = await http
          .post(Uri.parse(Config.apiURL + Config.dataencryptAPI), headers: {
        'Authorization': 'Bearer ${loginDetails!.data.token}',
      }, body: {
        'duration': json.encode(duration),
        'distance': json.encode(distance),
        'dataactv': json.encode(dataactv),
        'kal': json.encode(kal),
        'lastlatitude': json.encode(lastlatitude),
        'lastlongitude': json.encode(lastlongitude),
        'userId': loginDetails!.data.id
      });

      if (responsedata.statusCode != 200) {
        //var new encrypted = Encrypt.fromJson(jsonDecode(responsedata.body));
        return false;
      }
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future getData() async {
    try {
      var loginDetails = await SharedService.loginDetails();
      final jsonResponse = await http
          .get(Uri.parse(Config.apiURL + Config.historydataAPI), headers: {
        'Authorization': 'Bearer ${loginDetails!.data.token}',
      });

      print('Access token: ${loginDetails!.data.token}');

      if (jsonResponse.statusCode == 200) {
        print((jsonDecode(jsonResponse.body) as Map<String, dynamic>)['data']);
        Iterable it =
            (jsonDecode(jsonResponse.body) as Map<String, dynamic>)['data'];
        List<Historydata> historydata =
            it.map((e) => Historydata.fromJson(e)).toList();
        return historydata;
        //return Historydata.fromJson(jsonDecode(jsonResponse.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

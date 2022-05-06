import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'json_model.dart';

class JsonApi {
  bool loading = true;
  var json_Data;
  Future<JsonModel> getJsonData() async {
    var client = http.Client();
    String uri = "https://jsonplaceholder.typicode.com/users";
    var response = await client.get(Uri.parse(uri));
    var jsonModel = null;
    try {
      if (response.statusCode == 200) {
        var decode = json.decode(response.body);
        try{
          jsonModel = JsonModel.fromJson(decode);
        }
        catch(e) {
          print("e ${e.toString()}");
        }
        print(jsonModel);
      } else {
        throw Exception("falied to load");
      }
    } catch (Exception) {
      return jsonModel;
    }

    return jsonModel;
  }
}
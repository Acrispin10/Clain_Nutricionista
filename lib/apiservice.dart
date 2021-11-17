import 'package:http/http.dart';
import 'dart:convert';
import 'DataModel.dart';

class ServiceApi {
  static Future<List<dynamic>> getUserNotes() async {
    String url = 'https://backendclainapi.azurewebsites.net/api/clains';
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      print("Sirvio");
      return jsonDecode(response.body);
    }
    throw Exception(
        "Error llamando API - Status " + response.statusCode.toString());
  }

  static Future<void> postdata(String Dieta, String NombreDieta, String Info,
      String Menu, String Nota) async {
    String url = 'https://backendclainapi.azurewebsites.net/api/clains';
    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode({
          "dieta": Dieta,
          "nombreDieta": NombreDieta,
          "info": Info,
          "menu": Menu,
          "nota": Nota
        }));
    var data = response.body;
    print(data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      String responseString = response.body;
      dataModelFromJson(responseString);
    }
  }
}

import 'package:sistempakarfinal/model/gejala.dart';
import 'package:http/http.dart' show Client;

class ApiGejala {
  Client client = Client();

  Future<List<Gejala>> getGejala() async {
    final response = await client.get("http://laravelapi.test/api/v1/gejalas");
    if (response.statusCode == 200) {
      return gejalaFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createGejala(Gejala data) async {
    final response = await client.post(
      "http://laravelapi.test/api/v1/gejalas/create",
      headers: {"content-type": "application/json"},
      body: gejalaToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateGejala(Gejala data) async {
    final response = await client.put(
      "http://laravelapi.test/api/v1/gejalas/${data.id}/update",
      headers: {"content-type": "application/json"},
      body: gejalaToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteGejala(int id) async {
    final response = await client.delete(
      "http://laravelapi.test/api/v1/gejalas/${id}/destroy",
      headers: {
        "content-type": "application/json",
        "Accept": "application/json"
        },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
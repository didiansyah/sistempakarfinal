import 'package:sistempakarfinal/model/bobot.dart';
import 'package:http/http.dart' show Client;

class ApiBobot {
  Client client = Client();

  Future<List<Bobot>> getBobot() async {
    final response = await client.get("http://laravelapi.test/api/v1/bobots");
    if (response.statusCode == 200) {
      return bobotFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createBobot(Bobot data) async {
    final response = await client.post(
      "http://laravelapi.test/api/v1/bobots/create",
      headers: {"content-type": "application/json"},
      body: bobotToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateBobot(Bobot data) async {
    final response = await client.put(
      "http://laravelapi.test/api/v1/bobots/${data.id}/update",
      headers: {"content-type": "application/json"},
      body: bobotToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteBobot(int id) async {
    final response = await client.delete(
      "http://laravelapi.test/api/v1/bobots/${id}/destroy",
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
import 'package:sistempakarfinal/model/penyakit.dart';
import 'package:http/http.dart' show Client;

class ApiPenyakit {
  Client client = Client();

  Future<List<Penyakit>> getPenyakit() async {
    final response = await client.get("http://laravelapi.test/api/v1/penyakits");
    if (response.statusCode == 200) {
      return penyakitFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createPenyakit(Penyakit data) async {
    final response = await client.post(
      "http://laravelapi.test/api/v1/penyakits/create",
      headers: {"content-type": "application/json"},
      body: penyakitToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updatePenyakit(Penyakit data) async {
    final response = await client.put(
      "http://laravelapi.test/api/v1/penyakits/${data.id}/update",
      headers: {"content-type": "application/json"},
      body: penyakitToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePenyakit(int id) async {
    final response = await client.delete(
      "http://laravelapi.test/api/v1/penyakits/${id}/destroy",
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
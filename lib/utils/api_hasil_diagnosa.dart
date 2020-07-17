import 'dart:developer';
import 'dart:convert';

import 'package:sistempakarfinal/model/hasil_diagnosa.dart';
import 'package:http/http.dart' show Client;

class ApiHasilDiagnosa {
  Client client = Client();

  Future<Object> createHasilDiagnosaModel(data) async {
    try {
      final response = await client.post(
        "http://laravelapi.test/api/v1/hasil_diagnosas/create",
        headers: {"content-type": "application/json"},
        body: hasilDiagnosaModelToJson(data),
      );
      return json.decode(response.body);
    } catch (e) {
      log("error " + e.toString());
    }
  }
}

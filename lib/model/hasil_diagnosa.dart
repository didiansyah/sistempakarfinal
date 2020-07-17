import 'dart:convert';

import 'dart:developer';

class DiagnosaModel {
  int id;
  List<Object> gejala;
  String nama;
  String jenisKelamin;

  DiagnosaModel({this.id, this.gejala, this.nama, this.jenisKelamin});

  factory DiagnosaModel.fromJson(Map<String, dynamic> map) {
    return DiagnosaModel(
        id: map["id"],
        gejala: map["gejala"],
        nama: map['nama'],
        jenisKelamin: map['jenisKelamin']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "gejala": gejala,
      "nama": nama,
      "jenisKelamin": jenisKelamin
    };
  }

  @override
  String toString() {
    return 'DiagnosaModel{id: $id, gejala: $gejala, nama: $nama, jenisKelamin: $jenisKelamin}';
  }
}

List hasilDiagnosaModelFromJson(String jsonData) {
  try {
    final data = json.decode(jsonData);
    return List<DiagnosaModel>.from(
        data.map((item) => DiagnosaModel.fromJson(item)));
  } catch (e) {
    log("error parsing from json " + e.toString());
  }
}

String hasilDiagnosaModelToJson(DiagnosaModel data) {
  try {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  } catch (e) {
    log("error parsing to json" + e.toString());
  }
}

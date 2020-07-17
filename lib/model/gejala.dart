import 'dart:convert';

class Gejala {
  int id;
  String kode;
  String nama;

  Gejala({this.id, this.kode, this.nama});

  factory Gejala.fromJson(Map<String, dynamic> map) {
    return Gejala(id: map["id"], kode: map["kode"], nama: map['nama']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "kode": kode, "nama": nama};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, kode: $kode, nama: $nama}';
  }
}

List<Gejala> gejalaFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Gejala>.from(data.map((item) => Gejala.fromJson(item)));
}

String gejalaToJson(Gejala data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

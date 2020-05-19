import 'dart:convert';

class Gejala {
  int id;
  String kode;
  String nama;
  String bobot;

  Gejala({this.id, this.kode, this.nama, this.bobot});

  factory Gejala.fromJson(Map<String, dynamic> map) {
    return Gejala(
        id: map["id"], kode: map["kode"], nama: map['nama'], bobot: map['bobot']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "kode": kode, "nama": nama, "bobot": bobot};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, kode: $kode, nama: $nama, bobot: $bobot}';
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
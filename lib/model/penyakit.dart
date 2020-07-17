import 'dart:convert';

class Penyakit {
  int id;
  String kode;
  String nama;

  Penyakit({this.id, this.kode, this.nama});

  factory Penyakit.fromJson(Map<String, dynamic> map) {
    return Penyakit(id: map["id"], kode: map["kode"], nama: map['nama']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "kode": kode, "nama": nama};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, kode: $kode, nama: $nama}';
  }
}

List<Penyakit> penyakitFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Penyakit>.from(data.map((item) => Penyakit.fromJson(item)));
}

String penyakitToJson(Penyakit data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

import 'dart:convert';

class Bobot {
  int id;
  String keterangan;
  String bobotuser;

  Bobot({this.id, this.keterangan, this.bobotuser});

  factory Bobot.fromJson(Map<String, dynamic> map) {
    return Bobot(
        id: map["id"], keterangan: map["keterangan"], bobotuser: map['bobotuser']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "keterangan": keterangan, "bobotuser": bobotuser};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, keterangan: $keterangan, bobotuser: $bobotuser}';
  }

}


List<Bobot> bobotFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Bobot>.from(data.map((item) => Bobot.fromJson(item)));
}

String bobotToJson(Bobot data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
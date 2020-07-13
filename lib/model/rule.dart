import 'dart:convert';

class Rule {
  int id;
  String keterangan;
  String bobotuser;

  Rule({this.id, this.keterangan, this.bobotuser});

  factory Rule.fromJson(Map<String, dynamic> map) {
    return Rule(
        id: map["id"],
        keterangan: map["keterangan"],
        bobotuser: map['bobotuser']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "keterangan": keterangan, "bobotuser": bobotuser};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, keterangan: $keterangan, bobotuser: $bobotuser}';
  }
}

List<Rule> bobotFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Rule>.from(data.map((item) => Rule.fromJson(item)));
}

String bobotToJson(Rule data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

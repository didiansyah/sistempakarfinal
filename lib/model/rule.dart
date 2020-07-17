import 'dart:convert';

class Rule {
  int id;
  String penyakit;
  String gejala;
  String bobot;

  Rule({this.id, this.penyakit, this.gejala, this.bobot});

  factory Rule.fromJson(Map<String, dynamic> map) {
    return Rule(
      id: map["id"],
      penyakit: "[" + map["penyakit"]["kode"] + "]" + map["penyakit"]["nama"],
      gejala: "[" + map['gejala']['kode'] + "]" + map['gejala']['nama'],
      bobot: map['bobot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "penyakit": penyakit, "gejala": gejala, "bobot": bobot};
  }

  @override
  String toString() {
    return 'Penyakit{id: $id, penyakit: $penyakit, gejala: $gejala, bobot: $bobot}';
  }
}

List<Rule> ruleFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Rule>.from(data.map((item) => Rule.fromJson(item)));
}

String ruleToJson(Rule data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

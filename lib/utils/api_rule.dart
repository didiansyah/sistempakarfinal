import 'package:sistempakarfinal/model/rule.dart';
import 'package:http/http.dart' show Client;

class ApiRule {
  Client client = Client();

  Future<List<Rule>> getRule() async {
    final response = await client.get("http://laravelapi.test/api/v1/rules");
    if (response.statusCode == 200) {
      return ruleFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createRule(Rule data) async {
    final response = await client.post(
      "http://laravelapi.test/api/v1/rules/create",
      headers: {"content-type": "application/json"},
      body: ruleToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateRule(Rule data) async {
    final response = await client.put(
      "http://laravelapi.test/api/v1/rules/${data.id}/update",
      headers: {"content-type": "application/json"},
      body: ruleToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteRule(int id) async {
    final response = await client.delete(
      "http://laravelapi.test/api/v1/rules/${id}/destroy",
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

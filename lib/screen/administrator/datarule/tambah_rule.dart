import 'package:flutter/material.dart';
import 'package:sistempakarfinal/utils/api_rule.dart';
import 'package:sistempakarfinal/model/rule.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TambahRule extends StatefulWidget {
  Rule rule;

  TambahRule({this.rule});

  @override
  _TambahRuleState createState() => _TambahRuleState();
}

class _TambahRuleState extends State<TambahRule> {
  bool _isLoading = false;
  ApiRule _apiRule = ApiRule();
  bool _isFieldPenyakitValid;
  bool _isFieldGejalaValid;
  bool _isFieldBobotValid;
  TextEditingController _controllerPenyakit = TextEditingController();
  TextEditingController _controllerGejala = TextEditingController();
  TextEditingController _controllerBobot = TextEditingController();

  @override
  void initState() {
    if (widget.rule != null) {
      _isFieldPenyakitValid = true;
      _controllerPenyakit.text = widget.rule.penyakit;
      _isFieldGejalaValid = true;
      _controllerGejala.text = widget.rule.gejala;
      _isFieldBobotValid = true;
      _controllerBobot.text = widget.rule.bobot;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.rule == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldPenyakit(),
                _buildTextFieldGejala(),
                _buildTextFieldBobot(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.rule == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldPenyakitValid == null ||
                          _isFieldGejalaValid == null ||
                          _isFieldBobotValid == null ||
                          !_isFieldPenyakitValid ||
                          !_isFieldGejalaValid ||
                          !_isFieldBobotValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String penyakit = _controllerPenyakit.text.toString();
                      String gejala = _controllerGejala.text.toString();
                      String bobot = _controllerBobot.text.toString();
                      Rule rule = Rule(
                          penyakit: penyakit, gejala: gejala, bobot: bobot);
                      if (widget.rule == null) {
                        _apiRule.createRule(rule).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        rule.id = widget.rule.id;
                        _apiRule.updateRule(rule).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldPenyakit() {
    return TextField(
      controller: _controllerPenyakit,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Penyakit",
        errorText: _isFieldPenyakitValid == null || _isFieldPenyakitValid
            ? null
            : "Penyakit is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPenyakitValid) {
          setState(() => _isFieldPenyakitValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldGejala() {
    return TextField(
      controller: _controllerGejala,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Gejala",
        errorText: _isFieldGejalaValid == null || _isFieldGejalaValid
            ? null
            : "Gejala User is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldGejalaValid) {
          setState(() => _isFieldGejalaValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldBobot() {
    return TextField(
      controller: _controllerBobot,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Bobot",
        errorText: _isFieldBobotValid == null || _isFieldBobotValid
            ? null
            : "Bobot is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldBobotValid) {
          setState(() => _isFieldBobotValid = isFieldValid);
        }
      },
    );
  }
}

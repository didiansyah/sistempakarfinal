import 'package:flutter/material.dart';
import 'package:sistempakarfinal/utils/api_bobot.dart';
import 'package:sistempakarfinal/model/bobot.dart';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TambahBobot extends StatefulWidget {

  Bobot bobot;

  TambahBobot({this.bobot});

  @override
  _TambahBobotState createState() => _TambahBobotState();
}

class _TambahBobotState extends State<TambahBobot> {

  bool _isLoading = false;
  ApiBobot _apiBobot = ApiBobot();
  bool _isFieldKeteranganValid;
  bool _isFieldBobotuserValid;
  TextEditingController _controllerKeterangan = TextEditingController();
  TextEditingController _controllerBobotuser = TextEditingController();

  @override
  void initState() {
    if (widget.bobot != null) {
      _isFieldKeteranganValid = true;
      _controllerKeterangan.text = widget.bobot.keterangan;
      _isFieldBobotuserValid = true;
      _controllerBobotuser.text = widget.bobot.bobotuser;
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
          widget.bobot == null ? "Form Add" : "Change Data",
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
                _buildTextFieldKeterangan(),
                _buildTextFieldBobotuser(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.bobot == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldKeteranganValid == null ||
                          _isFieldBobotuserValid == null ||
                          !_isFieldKeteranganValid ||
                          !_isFieldBobotuserValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String keterangan = _controllerKeterangan.text.toString();
                      String bobotuser = _controllerBobotuser.text.toString();
                      Bobot bobot =
                          Bobot(keterangan: keterangan, bobotuser: bobotuser);
                      if (widget.bobot == null) {
                        _apiBobot.createBobot(bobot).then((isSuccess) {
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
                        bobot.id = widget.bobot.id;
                        _apiBobot.updateBobot(bobot).then((isSuccess) {
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

   Widget _buildTextFieldKeterangan() {
    return TextField(
      controller: _controllerKeterangan,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Keterangan",
        errorText: _isFieldKeteranganValid == null || _isFieldKeteranganValid
            ? null
            : "Keterangan is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKeteranganValid) {
          setState(() => _isFieldKeteranganValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldBobotuser() {
    return TextField(
      controller: _controllerBobotuser,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Bobot User",
        errorText: _isFieldBobotuserValid == null || _isFieldBobotuserValid
            ? null
            : "Bobot User is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldBobotuserValid) {
          setState(() => _isFieldBobotuserValid = isFieldValid);
        }
      },
    );
  }

}
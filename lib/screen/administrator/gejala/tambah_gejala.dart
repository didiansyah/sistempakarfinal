import 'package:flutter/material.dart';
import 'package:sistempakarfinal/utils/api_gejala.dart';
import 'package:sistempakarfinal/model/gejala.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class TambahGejala extends StatefulWidget {
  Gejala gejala;

  TambahGejala({this.gejala});

  @override
  _TambahGejalaState createState() => _TambahGejalaState();
}

class _TambahGejalaState extends State<TambahGejala> {
  bool _isLoading = false;
  ApiGejala _apiGejala = ApiGejala();
  bool _isFieldKodeValid;
  bool _isFieldNamaValid;
  TextEditingController _controllerKode = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();

  @override
  void initState() {
    if (widget.gejala != null) {
      _isFieldKodeValid = true;
      _controllerKode.text = widget.gejala.kode;
      _isFieldNamaValid = true;
      _controllerNama.text = widget.gejala.nama;
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
          widget.gejala == null ? "Form Add" : "Change Data",
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
                _buildTextFieldKode(),
                _buildTextFieldNama(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.gejala == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldKodeValid == null ||
                          _isFieldNamaValid == null ||
                          !_isFieldKodeValid ||
                          !_isFieldNamaValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String kode = _controllerKode.text.toString();
                      String nama = _controllerNama.text.toString();
                      Gejala gejala = Gejala(kode: kode, nama: nama);
                      if (widget.gejala == null) {
                        _apiGejala.createGejala(gejala).then((isSuccess) {
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
                        gejala.id = widget.gejala.id;
                        _apiGejala.updateGejala(gejala).then((isSuccess) {
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

  Widget _buildTextFieldKode() {
    return TextField(
      controller: _controllerKode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Kode Gejala",
        errorText: _isFieldKodeValid == null || _isFieldKodeValid
            ? null
            : "Kode Gejala is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldKodeValid) {
          setState(() => _isFieldKodeValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldNama() {
    return TextField(
      controller: _controllerNama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nama",
        errorText: _isFieldNamaValid == null || _isFieldNamaValid
            ? null
            : "Nama is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNamaValid) {
          setState(() => _isFieldNamaValid = isFieldValid);
        }
      },
    );
  }
}

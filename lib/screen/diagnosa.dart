import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:sistempakarfinal/screen/hasildiagnosa.dart';
import 'package:sistempakarfinal/utils/api_gejala.dart';
import 'package:sistempakarfinal/utils/api_hasil_diagnosa.dart';
import 'package:sistempakarfinal/model/gejala.dart';
import 'package:sistempakarfinal/model/hasil_diagnosa.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Diagnosa extends StatefulWidget {
  DiagnosaModel diagnosaModel;
  @override
  _DiagnosaState createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  ApiGejala apiGejala;
  ApiHasilDiagnosa apiHasilDiagnosa;
  List<bool> gejalaValue = new List<bool>();

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerJenisKelamin = TextEditingController();

  @override
  void initState() {
    if (widget.diagnosaModel != null) {
      _controllerJenisKelamin.text = widget.diagnosaModel.jenisKelamin;
      _controllerNama.text = widget.diagnosaModel.nama;
    }
    super.initState();
    apiGejala = ApiGejala();
  }

  void GejalaValueChange(bool val, int index) {
    setState(() {
      gejalaValue[index] = val;
    });
  }

  // List<String> allItemList = [
  //   'Penglihatan buram',
  //   'Benda terlihat kabur jika jarak dekat, \ntetapi benda terlihat jelas jika jarak jauh',
  //   'Kesulitan membaca tulisan dengan cetakan \nhuruf yang halus/kecil',
  //   'Sudah berusia lebih dari 40 tahun',
  //   'Benda terlihat kabur jika jarak jauh, \ntetapi benda terlihat jelas jika jarak dekat',
  //   'Menyipitkan mata untuk melihat obyek jauh',
  //   'Rabun pada malam hari',
  //   'Menyipitkan mata untuk melihat obyek dekat',
  //   'Masalah dalam membaca',
  //   'Suka memiringkan kepala saat melihat obyek',
  //   'Penglihatan dekat dan jauh kabur',
  //   'Tidak bisa melihat obyek jarak jauh \nmaupun jarak dekat',
  // ];

  List<String> checkedItemList = ['Green'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Diagnosa'),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 280),
                padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Data Diri',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Card(
                        elevation: 7.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: _controllerNama,
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Nama",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                TextFormField(
                                  controller: _controllerJenisKelamin,
                                  style: TextStyle(color: Color(0xFF000000)),
                                  cursorColor: Color(0xFF9b9b9b),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.supervised_user_circle,
                                      color: Colors.grey,
                                    ),
                                    hintText: "Jenis Kelamin",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF9b9b9b),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(right: 120),
                padding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Pilih Gejala Yang Kamu Alami',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              FutureBuilder(
                future: apiGejala.getGejala(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Gejala>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Something wrong with message: ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<Gejala> gejalas = snapshot.data;
                    return _buildListView(gejalas);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                height: 60.0,
                child: RaisedButton(
                    color: Colors.green,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        'Diagnosa',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    onPressed: () {
                      String nama = _controllerNama.text.toString();
                      String jenis_kelamin =
                          _controllerJenisKelamin.text.toString();
                      List gejala = gejalaValue;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HasilDiagnosa(DiagnosaModel(
                                nama: nama,
                                jenisKelamin: jenis_kelamin,
                                gejala: gejalaValue))),
                        (Route<dynamic> route) => false,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Gejala> gejalas) {
    for (int i = 0; i < gejalas.length; i++) {
      gejalaValue.add(false);
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Gejala gejala = gejalas[index];
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  CheckboxListTile(
                      value: gejalaValue[index],
                      title: Text(gejala.nama),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool val) {
                        GejalaValueChange(val, index);
                      }
                      // Text(
                      //   gejala.nama,
                      //   style: TextStyle(fontSize: 15),
                      // ),
                      ),
                ],
              ),
            ),
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: <Widget>[
            //   // Text(gejala.kode,
            //   //     style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
            //   Text(
            //     gejala.nama,
            //     style: TextStyle(fontSize: 15),
            //   ),
            // ],
          );
          // return Padding(
          //   padding: const EdgeInsets.only(top: 8.0),
          //   child: Card(
          //     elevation: 0,
          //     color: Color(0xFF1C1C1E),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),

          //     ),
          //   ),
          // );
        },
        itemCount: gejalas.length,
        //   ),
      ),
    );
  }
}

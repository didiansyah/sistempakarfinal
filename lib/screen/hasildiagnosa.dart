import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sistempakarfinal/screen/homemain.dart';
import 'package:sistempakarfinal/model/hasil_diagnosa.dart';
import 'package:sistempakarfinal/utils/api_hasil_diagnosa.dart';
import 'package:sistempakarfinal/components/wave_progress.dart';
import 'package:sistempakarfinal/components/screensize.dart';

class HasilDiagnosa extends StatefulWidget {
  final DiagnosaModel diagnosa;
  ApiHasilDiagnosa apiHasilDiagnosa;
  BuildContext context;

  HasilDiagnosa(this.diagnosa);

  @override
  _HasilDiagnosaState createState() => _HasilDiagnosaState();
}

class _HasilDiagnosaState extends State<HasilDiagnosa> {
  BuildContext context;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Diagnosa'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // CircleAvatar(
          //   radius: 50.0,
          //   backgroundColor: Color(0xFF2C2C2E),
          // ),
          SizedBox(
            height: 20.0,
            width: 100.0,
          ),
          Text(
            'Sistem Pakar Mendiagnosa Penyakit Refraksi',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Menggunakan Metode Certainty Factor',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Laporan Hasil Diagnosa Penyakit Refraksi',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 100.0,
          ),
          FutureBuilder(
            future:
                ApiHasilDiagnosa().createHasilDiagnosaModel(widget.diagnosa),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Something wrong with message: ${snapshot.error.toString()}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return _buildHasilDiagnosa(snapshot.data);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            height: 60.0,
            child: RaisedButton(
              color: Color(0xFF1C1C1E),
              elevation: 7.0,
              child: Center(
                child: Text(
                  'Kembali',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => HomeMain()));
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget vaweCard(BuildContext context, String name, String fields,
  //     Color fillColor, Color bgColor) {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       right: 20,
  //     ),
  //     padding: EdgeInsets.only(left: 15),
  //     height: screenAwareSize(25, widget.context),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Stack(
  //           alignment: Alignment.center,
  //           children: <Widget>[
  //             WaveProgress(
  //               screenAwareSize(10, widget.context),
  //               fillColor,
  //               bgColor,
  //               70,
  //             ),
  //             IconButton(
  //                 icon: Icon(Icons.verified_user),
  //                 color: Colors.white,
  //                 onPressed: () {}),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHasilDiagnosa(data) {
    log(data.toString());
    return Card(
      color: Colors.white,
      elevation: 6.0,
      margin: EdgeInsets.only(right: 15.0, left: 15.0),
      child: Wrap(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
            ),
          ),
          // vaweCard(
          //   widget.context,
          //   "User",
          //   "Wave",
          //   Colors.grey.shade100,
          //   Color(0xFF3CB371),
          // ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                data['nama'] ?? ' ',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                data['jenisKelamin'] ?? ' ',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 20, top: 20),
            child: Center(
              child: Text(
                data['hasil'] ?? ' ',
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: Text.rich(
                TextSpan(
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Harap untuk konsultasi lebih lanjut ke Dokter',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.black45)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

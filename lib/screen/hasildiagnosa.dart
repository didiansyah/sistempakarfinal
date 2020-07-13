import 'package:flutter/material.dart';
import 'package:sistempakarfinal/screen/homemain.dart';

class HasilDiagnosa extends StatefulWidget {
  @override
  _HasilDiagnosaState createState() => _HasilDiagnosaState();
}

class _HasilDiagnosaState extends State<HasilDiagnosa> {
  @override
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
          Card(
            color: Colors.white,
            elevation: 6.0,
            margin: EdgeInsets.only(right: 15.0, left: 15.0),
            child: Wrap(
              children: <Widget>[
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Didi Khodriansyah',
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
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Laki-Laki',
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
                  margin: EdgeInsets.only(left: 60, right: 20, top: 40),
                  child: Center(
                    child: Text(
                      "Kamu mengalami Penyakit Miopia dengan nilai CF 0.904 atau 90.4%",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 40.0, top: 20.0),
                    child: Text.rich(
                      TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'Harap untuk konsultasi lebih lanjut ke Dokter',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black45)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
}

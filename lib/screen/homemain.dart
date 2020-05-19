import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistempakarfinal/screen/login_page.dart';
import 'package:sistempakarfinal/screen/diagnosa.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Sistem Pakar',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Mendiagnosa Penyakit Refraksi',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            Text(
              'Menggunakan Metode Certainty Factor',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 100.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              height: 60.0,
              child: RaisedButton(
                color: Colors.green,
                elevation: 7.0,                        
                  child: Center(
                    child: Text(
                      'Mulai Diagnosa',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => Diagnosa()));
                  },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => LoginPage()));
                },
                child: Text(
                  'Masuk sebagai admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            
          ],
        ),
    );
  }
}
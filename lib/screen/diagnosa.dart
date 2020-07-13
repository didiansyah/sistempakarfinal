import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:sistempakarfinal/screen/hasildiagnosa.dart';

class Diagnosa extends StatefulWidget {
  @override
  _DiagnosaState createState() => _DiagnosaState();
}

class _DiagnosaState extends State<Diagnosa> {
  List<String> allItemList = [
    'Penglihatan buram',
    'Benda terlihat kabur jika jarak dekat, \ntetapi benda terlihat jelas jika jarak jauh',
    'Kesulitan membaca tulisan dengan cetakan \nhuruf yang halus/kecil',
    'Sudah berusia lebih dari 40 tahun',
    'Benda terlihat kabur jika jarak jauh, \ntetapi benda terlihat jelas jika jarak dekat',
    'Menyipitkan mata untuk melihat obyek jauh',
    'Rabun pada malam hari',
    'Menyipitkan mata untuk melihat obyek dekat',
    'Masalah dalam membaca',
    'Suka memiringkan kepala saat melihat obyek',
    'Penglihatan dekat dan jauh kabur',
    'Tidak bisa melihat obyek jarak jauh \nmaupun jarak dekat',
  ];

  List<String> checkedItemList = ['Green'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnosa'),
      ),
      body: Container(
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
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
            GroupedCheckbox(
              wrapSpacing: 5.0,
              wrapRunSpacing: 10.0,
              wrapTextDirection: TextDirection.ltr,
              wrapRunAlignment: WrapAlignment.center,
              wrapVerticalDirection: VerticalDirection.down,
              wrapAlignment: WrapAlignment.center,
              itemList: allItemList,
              checkedItemList: checkedItemList,
              onChanged: (itemList) {
                // setState(() {
                //   selectedItemList = itemList;
                //   print('SELECTED ITEM LIST $itemList');
                //   });
              },
              orientation: CheckboxOrientation.VERTICAL,
              checkColor: Colors.white,
              activeColor: Colors.green,
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HasilDiagnosa()),
                      (Route<dynamic> route) => false,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

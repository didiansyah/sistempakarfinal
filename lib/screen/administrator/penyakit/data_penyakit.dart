import 'package:flutter/material.dart';
import 'package:sistempakarfinal/utils/api_penyakit.dart';
import 'package:sistempakarfinal/model/penyakit.dart';
import 'package:sistempakarfinal/screen/administrator/penyakit/tambah_penyakit.dart';

class DataPenyakit extends StatefulWidget {
  @override
  _DataPenyakitState createState() => _DataPenyakitState();
}

class _DataPenyakitState extends State<DataPenyakit> {

  BuildContext context;
  ApiPenyakit apiPenyakit;

  @override
  void initState() {
    super.initState();
    apiPenyakit = ApiPenyakit();
  }

@override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Penyakit'),
      ),
    body: SafeArea(
      child: FutureBuilder(
        future: apiPenyakit.getPenyakit(),
        builder: (BuildContext context, AsyncSnapshot<List<Penyakit>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Penyakit> penyakits = snapshot.data;
            return _buildListView(penyakits);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ),
    floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            onPressed: (){
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => TambahPenyakit()));
            },
            icon: Icon(Icons.add, color: Colors.white,),
            label: Text("Tambah Data Penyakit", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildListView(List<Penyakit> penyakits) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Penyakit penyakit = penyakits[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              elevation: 0,
              color: Color(0xFF1C1C1E),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      penyakit.nama,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(penyakit.kode),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text(
                                        "Are you sure want to delete data penyakit ${penyakit.nama}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiPenyakit .deletePenyakit(penyakit.id) .then((isSuccess) {

                                                
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Delete data success")));
                                            } else {

                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Delete data failed")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TambahPenyakit(penyakit: penyakit);
                            }));
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: penyakits.length,
      ),
    );
  }
}

  
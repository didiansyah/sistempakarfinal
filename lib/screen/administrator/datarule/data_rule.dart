import 'package:flutter/material.dart';
import 'package:sistempakarfinal/utils/api_bobot.dart';
import 'package:sistempakarfinal/model/bobot.dart';
import 'package:sistempakarfinal/screen/administrator/datarule/tambah_rule.dart';

class DataRule extends StatefulWidget {
  @override
  _DataRuleState createState() => _DataRuleState();
}

class _DataRuleState extends State<DataRule> {
  BuildContext context;
  ApiBobot apiBobot;

  @override
  void initState() {
    super.initState();
    apiBobot = ApiBobot();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Rule'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiBobot.getBobot(),
          builder: (BuildContext context, AsyncSnapshot<List<Bobot>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Bobot> bobots = snapshot.data;
              return _buildListView(bobots);
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
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => TambahRule()));
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              "Tambah Data Rule",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildListView(List<Bobot> bobots) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Bobot bobot = bobots[index];
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
                      bobot.keterangan,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(bobot.bobotuser),
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
                                        "Are you sure want to delete data rule ${bobot.keterangan}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiBobot
                                              .deleteBobot(bobot.id)
                                              .then((isSuccess) {
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
                              return TambahRule(bobot: bobot);
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
        itemCount: bobots.length,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sistempakarfinal/components/icon_content.dart';
import 'package:sistempakarfinal/components/reusable_card.dart';
import 'package:sistempakarfinal/components/round_icon_button.dart';
import 'package:sistempakarfinal/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sistempakarfinal/screen/administrator/account.dart';
import 'package:sistempakarfinal/screen/administrator/penyakit/data_penyakit.dart';
import 'package:sistempakarfinal/screen/administrator/gejala/data_gejala.dart';
import 'package:sistempakarfinal/screen/administrator/datarule/data_rule.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Refraksi Certainty Factor'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Akun()));
            },
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
          Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DataPenyakit()));
                  },
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.bookmark,
                    label: 'Data Penyakit',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DataGejala()));
                  },
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.clone,
                    label: 'Data Gejala',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DataRule()));
                  },
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.chartBar,
                    label: 'Data Rule',
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

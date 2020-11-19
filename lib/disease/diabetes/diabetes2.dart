import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ragaviz/disease/diabetes/raga_selector_diabetes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Diabetes2 extends StatefulWidget {
  _Diabetes2 createState() => _Diabetes2();
}

class _Diabetes2 extends State<Diabetes2> {
  var records = []; // variable records is defined as empty array.
  var _email; // variable email is defined.

  TextEditingController bslController = new TextEditingController();

  var displayName; // variable display name is defined.

  Future _getNameOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userDisplayName') ?? "Patient";
    return name;
  } // get thing from shared preferences.

  final DatabaseReference databaseReference = FirebaseDatabase.instance
      .reference()
      .child("User"); //create realtime database with name user.

  sendData() async {
    var doc1 = {
      'email-id': _email,
      'name': displayName,
    };
    databaseReference.push().set(doc1);
  } // collect this data and send to real time database.

  @override
  void initState() {
    getMyRecords();
//    getMyRecords2();
    super.initState();
    _getNameOnStartup().then((value) => {
          setState(() {
            displayName = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          height: double.infinity,
          width: double.infinity,
          color: Color(0xFFf5f5f2),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF004761),
                )),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[],
          ), // App bar with back icon which navigate to previous page.
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Center(
                    child: Text(
                        'Normal fasting blood sugar is less than 100 mg/dl',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Source Sans Pro')),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter your Blood Sugar Level:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Material(
                    color: Colors.transparent,
                    shadowColor: Colors.black38,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    child: TextFormField(
                      autofocus: false,
                      controller: bslController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Blood Sugar Level (Mg/dl)",
                          fillColor: Colors.white),
                    ), // input field for bsl.
                  ),
                  width: MediaQuery.of(context).size.width - 100),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xFF004761))),
                    onPressed: () {
                      saveData();
                      sendData();
                    },
                    color: Color(0xFF004761),
                    textColor: Colors.white,
                    child: Text("NOTE", style: TextStyle(fontSize: 14)),
                  ), // note button which saves the data and sends to database
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xFF004761))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RagaSelectorDiabetes()));
                    },
                    color: Color(0xFF004761),
                    textColor: Colors.white,
                    child: Text(
                      'RAGAS',
                      style: TextStyle(fontSize: 14),
                    ),
                  ), // ragas button which navigates to the ragas page.
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.blue),
                columnWidths: {
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2)
                }, // create table
                children: loadRecords(),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }

  Future _getThingsOnStartup1() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmailAddress') ?? 0;
    return email;
  } // get thing from shared preferences.

  Future getMyRecords() async {
    _email = await _getThingsOnStartup1();
    Firestore.instance
        .collection("diabetes")
        .where("email", isEqualTo: _email)
        .where("name", isEqualTo: displayName)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  } // get records from database

  Widget loadGraph() {
    Widget response;
    List<TimeSeriesBSL> data = [];
    for (int i = 0; i < records.length && i < 5; i++) {
      Timestamp timestamp = records[i]['notedOn'];
      data.add(new TimeSeriesBSL(
          new DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch),
          records[i]['bsl'].round()));
    }
    response = SimpleTimeSeriesChart(SimpleTimeSeriesChart.createData(data));
    return response;
  }

  loadRecords() {
    var response = [
      TableRow(children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Date And Time", textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("BSL (Mg/dl)", textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Remark", textAlign: TextAlign.center)),
      ])
    ];
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    for (int i = 0; i < records.length; i++) {
      Timestamp timestamp = records[i]['notedOn'];
      response.add(TableRow(children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
                f.format(new DateTime.fromMillisecondsSinceEpoch(
                    timestamp.millisecondsSinceEpoch)),
                textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(records[i]['bsl'].toString(),
                textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(records[i]['status'], textAlign: TextAlign.center)),
      ]));
    }
    return response;
  }

  saveData() {
    double bsl;
    try {
      bsl = double.parse(bslController.text);
    } catch (e) {
      showAlertDialogWrongBSL(context);
      return;
    }
    var status = "N";
    if (bsl > 180) {
      status = "P";
    }
    var doc = {
      'email': _email,
      'name': displayName,
      'bsl': bsl,
      'status': status,
      'notedOn': new DateTime.now().toUtc()
    };
    bslController.clear();
    Firestore.instance
        .collection("diabetes")
        .add(doc)
        .then((value) => {showAlertDialogResult(context, status)});
  } // save the data int the database.

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('FirebaseDatabase', FirebaseDatabase));
    properties.add(DiagnosticsProperty('FirebaseDatabase', FirebaseDatabase));
    properties.add(DiagnosticsProperty('_name', displayName));
  }
}

showAlertDialogWrongBSL(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Required Field Error"),
    content: Text("Blood Sugar Level Should be number"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogResult(BuildContext context, result) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Noted Successfully"),
    content: Text("Analysis is :" + result),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleTimeSeriesChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesBSL, DateTime>> createData(data) {
    return [
      new charts.Series<TimeSeriesBSL, DateTime>(
        id: 'BSL',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesBSL bsl, _) => bsl.time,
        measureFn: (TimeSeriesBSL bsl, _) => bsl.bsl,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.

class TimeSeriesBSL {
  final DateTime time;
  final int bsl;

  TimeSeriesBSL(this.time, this.bsl);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ragaviz/disease/lowbp/raga_selector_lowbp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LowBP2 extends StatefulWidget {
  _LowBP2 createState() => _LowBP2();
}

class _LowBP2 extends State<LowBP2> {
  var records = [];

  var _email;

  TextEditingController systolicController = new TextEditingController();
  TextEditingController diastolicController = new TextEditingController();

  @override
  void initState() {
    getMyRecords();
    super.initState();
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
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Text(
                      "Normal Range for Systolic is less than 120 mm Hg.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                      "Normal Range for Diastolic is less than 80 mm Hg.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter your Blood Pressure Readings :',
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
                      controller: systolicController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Systolic (mmHg)",
                          fillColor: Colors.white),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 100),
              Container(
                  child: Material(
                    color: Colors.transparent,
                    shadowColor: Colors.black38,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    child: TextFormField(
                      autofocus: false,
                      controller: diastolicController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Diastolic (mmHg)",
                          fillColor: Colors.white),
                    ),
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
                    },
                    color: Color(0xFF004761),
                    textColor: Colors.white,
                    child: Text("Note".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xFF004761))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RagaSelectorLowBP()));
                    },
                    color: Color(0xFF004761),
                    textColor: Colors.white,
                    child: Text(
                      'RAGAS',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.blue),
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2)
                },
                children: loadRecords(),
              ),
              SizedBox(
                height: 10,
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

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userEmailAddress') ?? "xyz@gmail.com";
    return name;
  }

  Future getMyRecords() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("lowbp")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  loadRecords() {
    var response = [
      TableRow(children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Date And Time", textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Systolic (Mg/dl)", textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Diastolic (Mg/dl)", textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Remark", textAlign: TextAlign.center)),
      ])
    ];
    /*
    if(records.length==0){
      response.add(

      );
    }*/
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
            child: Text(records[i]['systolic'].toString(),
                textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(records[i]['diastolic'].toString(),
                textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(records[i]['status'], textAlign: TextAlign.center)),
      ]));
    }
    return response;
  }

  saveData() {
    double systolic;
    try {
      systolic = double.parse(systolicController.text);
    } catch (e) {
      showAlertDialogWrongSystolic(context);
      return;
    }
    double diastolic;
    try {
      diastolic = double.parse(diastolicController.text);
    } catch (e) {
      showAlertDialogWrongDiastolic(context);
      return;
    }
    var status = "NBP";
    if (systolic > 130 || diastolic > 80) {
      status = "HBP";
    }
    if (systolic < 80 || diastolic < 60) {
      status = "LBP";
    }
    var doc = {
      'email': _email,
      'systolic': systolic,
      'diastolic': diastolic,
      'status': status,
      'notedOn': new DateTime.now().toUtc()
    };
    systolicController.clear();
    diastolicController.clear();
    Firestore.instance
        .collection("lowbp")
        .add(doc)
        .then((value) => {showAlertDialogResult(context, status)});
  }

  Widget loadGraph() {
    Widget response;
    List<TimeSeriesWave> systolic = [];
    List<TimeSeriesWave> diastolic = [];
    for (int i = 0; i < records.length && i < 5; i++) {
      Timestamp timestamp = records[i]['notedOn'];
      systolic.add(new TimeSeriesWave(
          new DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch),
          records[i]['systolic'].round()));
      diastolic.add(new TimeSeriesWave(
          new DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch),
          records[i]['diastolic'].round()));
    }
    response = SimpleTimeSeriesChart(
        SimpleTimeSeriesChart.createData(systolic, diastolic));
    return response;
  }
}

showAlertDialogWrongSystolic(BuildContext context) {
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
    content: Text("Systolic Should be number"),
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

showAlertDialogWrongDiastolic(BuildContext context) {
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
    content: Text("Diastolic Should be number"),
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

/// Sample time series data type.
class TimeSeriesWave {
  final DateTime time;
  final int wave;

  TimeSeriesWave(this.time, this.wave);
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
      layoutConfig: new charts.LayoutConfig(
          rightMarginSpec: new charts.MarginSpec.fixedPixel(40)),
      behaviors: [
        new charts.RangeAnnotation([
          new charts.RangeAnnotationSegment(
              60, 80, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'NRD',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.green.shadeDefault.lighter),
          new charts.RangeAnnotationSegment(
              80, 130, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'NRS',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.green.shadeDefault)
        ], defaultLabelPosition: charts.AnnotationLabelPosition.margin)
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesWave, DateTime>> createData(
      systolic, diastolic) {
    return [
      new charts.Series<TimeSeriesWave, DateTime>(
        id: 'systolic',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWave wave, _) => wave.time,
        measureFn: (TimeSeriesWave wave, _) => wave.wave,
        data: systolic,
      ),
      new charts.Series<TimeSeriesWave, DateTime>(
        id: 'diastolic',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesWave wave, _) => wave.time,
        measureFn: (TimeSeriesWave wave, _) => wave.wave,
        data: diastolic,
      )
    ];
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:ragaviz/disease/stress/raga_selector_stress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Stress2 extends StatefulWidget {
  _Stress2 createState() => _Stress2();
}

class _Stress2 extends State<Stress2> {
  var records = [];

  var _email;

  TextEditingController wfController = new TextEditingController();

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
                      "EEG rhythms are classified into four basic types:      \n(i) Delta (1/2 - 4 cycles per second)                   \n(ii)Theta (4-7 cycles per second)                      \n(iii)Alpha (8-13 cycles per second)                         \n(iv)Beta (13- 40 cycles per second)",
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
                'Enter your EEG Readings :',
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
                      controller: wfController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          labelText: "Wave Frequency (Hz)",
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
                              builder: (context) => RagaSelectorStress()));
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
                  0: FlexColumnWidth(5),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(2)
                },
                children: loadRecords(),
              ),
              SizedBox(
                height: 20,
              ),
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
        .collection("stress")
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
            child: Text("WF (Hz)", textAlign: TextAlign.center)),
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
            child:
                Text(records[i]['wf'].toString(), textAlign: TextAlign.center)),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(records[i]['status'], textAlign: TextAlign.center)),
      ]));
    }
    return response;
  }

  saveData() {
    double wf;
    try {
      wf = double.parse(wfController.text);
    } catch (e) {
      showAlertDialogWrongWF(context);
      return;
    }
    var status = "N";
    if (wf >= 30 && wf < 50) {
      status = 'γ';
    } else if (wf >= 13 && wf < 30) {
      status = 'β';
    } else if (wf >= 8 && wf < 13) {
      status = 'α';
    } else if (wf >= 4 && wf < 8) {
      status = 'θ';
    } else {
      status = 'δ';
    }
    var doc = {
      'email': _email,
      'wf': wf,
      'status': status,
      'notedOn': new DateTime.now().toUtc()
    };
    wfController.clear();
    Firestore.instance
        .collection("stress")
        .add(doc)
        .then((value) => {showAlertDialogResult(context, status)});
  }

  Widget loadGraph() {
    Widget response;
    List<TimeSeriesWF> data = [];
    for (int i = 0; i < records.length && i < 5; i++) {
      Timestamp timestamp = records[i]['notedOn'];
      data.add(new TimeSeriesWF(
          new DateTime.fromMillisecondsSinceEpoch(
              timestamp.millisecondsSinceEpoch),
          records[i]['wf'].round()));
    }
    response = SimpleTimeSeriesChart(SimpleTimeSeriesChart.createData(data));
    return response;
  }
}

showAlertDialogWrongWF(BuildContext context) {
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
    content: Text("Wave Frequency Should be number"),
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
class TimeSeriesWF {
  final DateTime time;
  final int wf;

  TimeSeriesWF(this.time, this.wf);
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
        rightMarginSpec: new charts.MarginSpec.fixedPixel(40),
      ),
      behaviors: [
        new charts.RangeAnnotation([
          new charts.RangeAnnotationSegment(
              0, 4, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'δ',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade100),
          new charts.RangeAnnotationSegment(
              4, 8, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'θ',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade200),
          new charts.RangeAnnotationSegment(
              8, 13, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'α',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade300),
          new charts.RangeAnnotationSegment(
              13, 30, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'β',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade400),
          new charts.RangeAnnotationSegment(
              30, 50, charts.RangeAnnotationAxisType.measure,
              middleLabel: 'γ',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade500),
        ], defaultLabelPosition: charts.AnnotationLabelPosition.margin)
      ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<TimeSeriesWF, DateTime>> createData(data) {
    return [
      new charts.Series<TimeSeriesWF, DateTime>(
        id: 'WF',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesWF wf, _) => wf.time,
        measureFn: (TimeSeriesWF wf, _) => wf.wf,
        data: data,
      )
    ];
  }
}

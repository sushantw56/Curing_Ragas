import 'package:flutter/material.dart';
import 'package:ragaviz/disease/diabetes/diabetes2.dart';

class Diabetes1 extends StatefulWidget {
  _Diabetes1 createState() => _Diabetes1();
}

class _Diabetes1 extends State<Diabetes1> {
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
              ),
            ),
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
              Container(
                child: Center(
                  child: Text("Diabetes",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Diabetes is a disease that occurs when your blood glucose, also called blood sugar, is too high. Blood glucose is your main source of energy and comes from the food you eat. Insulin, a hormone made by the pancreas, helps glucose from food get into your cells to be used for energy.",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ragas for Diabetes :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Source Sans Pro',
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '1.  Raga Bageshri',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '2.  Raga Chandrakauns',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '3.  Raga Puriya Dhanashree',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '4.  Raga Ganamurti',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Diabetes2(),
                          fullscreenDialog: true));
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                color: Color(0xFF004761),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20),
                ),
              ), // button which navigates to next page of diabetes.
            ],
          ),
        ),
      ],
    );
  }
}

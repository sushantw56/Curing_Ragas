import 'package:flutter/material.dart';
import 'low2.dart';

class LowBP1 extends StatefulWidget {
  _LowBP1 createState() => _LowBP1();
}

class _LowBP1 extends State<LowBP1> {
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
                  child: Text("Low Blood Pressure",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Most doctors consider blood pressure too low only if it causes symptoms. Some experts define low blood pressure as readings lower than 90 mm Hg systolic or 60 mm Hg diastolic. If either number is below that, your pressure is lower than normal.",
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
                "Ragas for Low Blood Pressure",
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
                '1.  Raga Malkauns',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '2.  Raga Asawari',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '4.  Raga Vasanta/Vasanti',
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
                          builder: (context) => LowBP2(),
                          fullscreenDialog: true));
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                color: Color(0xFF004761),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

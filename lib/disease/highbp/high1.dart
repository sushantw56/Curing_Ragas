import 'package:flutter/material.dart';
import 'high2.dart';

class HighBP1 extends StatefulWidget {
  _HighBP1 createState() => _HighBP1();
}

class _HighBP1 extends State<HighBP1> {
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
                  child: Text("High Blood Pressure",
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
                "High blood pressure, or hypertension, occurs when your blood pressure increases to unhealthy levels. Your blood pressure measurement takes into account how much blood is passing through your blood vessels and the amount of resistance the blood meets while the heart is pumping. Narrow arteries increase resistance.",
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
                "Ragas for High Blood Pressure :",
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
                '1.  Raga Todi',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '2.  Raga Ahir-Bhairav',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '3.  Raga Bhupali',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '4.  Raga Puriya Dhanashree',
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
                          builder: (context) => HighBP2(),
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

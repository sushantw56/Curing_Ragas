import 'package:flutter/material.dart';
import 'package:ragaviz/disease/stress/stress2.dart';

class Stress1 extends StatefulWidget {
  _Stress1 createState() => _Stress1();
}

class _Stress1 extends State<Stress1> {
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
                  child: Text("Stress",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
              Text(
                "Stress is a feeling of emotional or physical tension. It can come from any event or thought that makes you feel frustrated, angry, or nervous. Stress is your body's reaction to a challenge or demand. In short bursts, stress can be positive, such as when it helps you avoid danger or meet a deadline.",
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
                "Ragas for Stress",
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
                '1.  Raga Darbari',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '2.  Raga Hindol',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '3.  Raga Shree',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '4.  Raga Yaman',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '5.  Raga Marwa',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '6.  Raga Kedaram',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '7.  Raga Nilambari',
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
                          builder: (context) => Stress2(),
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

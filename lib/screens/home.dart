import 'package:flutter/material.dart';
import 'package:ragaviz/disease/diabetes/diabetes1.dart';
import 'package:ragaviz/disease/highbp/high1.dart';
import 'package:ragaviz/disease/lowbp/low1.dart';
import 'package:ragaviz/disease/stress/stress1.dart';
import 'package:ragaviz/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  var displayName = "Loading.....";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getThingsOnStartup().then((value) => {
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
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      logOut();
                    },
                    child: Center(
                      child: Text(
                        "Log-Out",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF004761)),
                      ),
                    ),
                  ))
            ],
          ), // App bar with log out option
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: Text("Hello, ${displayName}",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Source Sans Pro')),
                ),
                width: MediaQuery.of(context).size.width,
                height: 40,
              ),
              Container(
                child: DiseaseGrid(),
                height: 700,
              ) // create a grid
            ],
          ),
        ),
      ],
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userDisplayName') ?? "Patient";
    return name;
  } // get thing from shared preferences.

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isLoggedIn'
        '',
        false);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  } // function logOut is defined
}

class DiseaseGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: [
          GridTile(
              child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Diabetes1(),
                          fullscreenDialog: true));
                },
                child: Image.asset(
                  'assets/images/diabetes.jpg',
                  fit: BoxFit.fill,
                )), // A block for diabetes which on tapped opens diabetes page.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          )),
          GridTile(
              child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Stress1(),
                          fullscreenDialog: true));
                },
                child: Image.asset(
                  'assets/images/stress.jpg',
                  fit: BoxFit.fill,
                )), // A block for stress which on tapped opens stress page.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          )),
          GridTile(
              child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LowBP1(),
                          fullscreenDialog: true));
                },
                child: Image.asset(
                  'assets/images/lbp.jpg',
                  fit: BoxFit.fill,
                )), // A block for low bp which on tapped opens low bp page.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          )),
          GridTile(
              child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HighBP1(),
                          fullscreenDialog: true));
                },
                child: Image.asset(
                  'assets/images/hbp.jpg',
                  fit: BoxFit.fill,
                )), // A block for high bp which on tapped opens high bp page.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          ))
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:ragaviz/screens/home.dart';
import 'package:ragaviz/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
} // WelcomePage class is created as stateful widget.

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print(value);
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } // If the user is already Logged In then it goes to home else it opens the login screen.
    });
    super.initState();
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  } // Method _getThingsOnStartup is created.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFf5f5f2),
        child: Center(
          child: Column(children: [
            SizedBox(height: 220),
            Text(
              "Curing Ragas",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Text(
              "Developed by",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontFamily: 'Source Sans Pro'),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              "Dr. Milind Nemade",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Source Sans Pro'),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 50),
            Text(
              "Department of Electronics Engineering",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "K. J. Somaiya Institute of Engineering & Information Technology Sion,Mumbai",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  } // The text which is to displayed on the welcome page is added.
}

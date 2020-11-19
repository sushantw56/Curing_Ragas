import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ragaviz/screens/home.dart';
import 'package:ragaviz/screens/password_reset.dart';
import 'package:ragaviz/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false; // Boolean for auto validate is defined as false.
  String _email; // String for email is defined.
  String _password; // String for password is defined.

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
          appBar: new AppBar(
            leading: Container(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                              fullscreenDialog: true));
                    },
                    child: Center(
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF004761)),
                      ),
                    ),
                  ))
            ],
          ), // It creates an AppBar which has an icon with arrow indication back and a gesture Detector named Sign Up which on tapped navigates to the signup page.
          body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Center(
                    child: Text("Log in",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Container(
                        width: 300.0,
                        height: 300.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/logo.png"))))),
                SizedBox(
                  height: 50,
                ),
                Container(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 20.0,
                      shadowColor: Colors.black38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        autofocus: false,
                        obscureText: false,
                        onSaved: (input) => _email = input,
                        decoration: InputDecoration(
                            labelText: "Email Address",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white),
                      ), // It creates a text input box with label text as Email Address.
                    ),
                    width: MediaQuery.of(context).size.width - 100),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 20.0,
                      shadowColor: Colors.black38,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: true,
                        validator: validatePassword,
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: "Password",
                            fillColor: Colors.white),
                      ), // It creates a text input box with label text as Password.
                    ),
                    width: MediaQuery.of(context).size.width - 100),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xFF004761))),
                  onPressed: signIn,
                  color: Color(0xFF004761),
                  textColor: Colors.white,
                  child: Text("Log In".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotScreen()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 17),
                    )) // It creates a Raised button with text Log In which on pressed call the function signIn.
              ],
            ),
          ),
        ),
      ],
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password));
        print(user);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userDisplayName', user.displayName);
        await prefs.setString('userEmailAddress', user.email);
        await prefs.setString('userUID', user.uid);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home())); // If the data entered is correct navigate to home page.
      } catch (e) {
        showAlertDialogWrongCred(this.context);
      }
    } else {
//    If all data are not valid then start auto validation.

      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validatePassword(String value) {
    if (value.length < 7)
      return 'Password must be more than 6 charater';
    else
      return null;
  } // validation for password

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  } // validation for Email Address
}

showAlertDialogWrongCred(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Login Failed"),
    content: Text("Email Address or Password incorrect."),
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
} // alert dialog box if entered details are incorrect.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/screens/login.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  String email = "";
  var _formKey = GlobalKey<FormState>();

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
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 35.0),
              children: [
                Container(
                  child: Center(
                    child: Text("Reset Password",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                ),
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter your email";
                          } else {
                            email = value;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Enter your registered Email Address",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white),
                      ), // It creates a text input box with label text as Email Address.
                    ),
                    width: MediaQuery.of(context).size.width - 100),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xFF004761))),
                  onPressed: () {
                    resetPassword();
                  },
                  color: Color(0xFF004761),
                  textColor: Colors.white,
                  child: Text("reset".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void resetPassword() async {
    if (_formKey.currentState.validate()) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => print("email sent"));
    }
    Navigator.pop(context);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

showAlertResetSuccessful(BuildContext context, result) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Password reset successful"),
    content: Text("Now login with your new password"),
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

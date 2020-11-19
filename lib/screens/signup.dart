import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ragaviz/screens/login.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false; // Boolean for auto validate is defined as false.
  String _email; // String for email is defined.
  String _age; // String for age is defined.
  String _name; // String for name is defined.
  String _password; // String for password is defined.
  String _doctorName; // String for doctor name is defined.
  String _userAddress; // String for address is defined.
  String get name => _name; // add getter for name.
  String get email => _email; // add getter for email.
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
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                              fullscreenDialog: true));
                    },
                    child: Center(
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF004761)),
                      ),
                    ),
                  ))
            ],
          ), // AppBar with back icon which navigates to previous page and login in gesture detector which on tapped navigates to login page.
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
                    child: Text("Sign Up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                ),
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
                        validator: validateName,
                        autofocus: false,
                        obscureText: false,
                        onSaved: (input) => _name = input,
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white),
                      ), // Input name.
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
                        keyboardType: TextInputType.number,
                        validator: validateName,
                        autofocus: false,
                        obscureText: false,
                        onSaved: (input) => _age = input,
                        decoration: InputDecoration(
                            labelText: "Age",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white),
                      ), // Input age.
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
                      ), // Input Email Address.
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
                        onSaved: (input) => _password = input,
                        validator: validatePassword,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: "Password",
                            fillColor: Colors.white),
                      ), // Input Password.
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
                        onSaved: (input) => _doctorName = input,
                        validator: validateName,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: "Doctor Name",
                            fillColor: Colors.white),
                      ), // Input Doctor name.
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
                        onSaved: (input) => _userAddress = input,
                        validator: validateAddress,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            labelText: "Address",
                            fillColor: Colors.white),
                      ), // Input address.
                    ),
                    width: MediaQuery.of(context).size.width - 100),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xFF004761))),
                  onPressed: signUp,
                  color: Color(0xFF004761),
                  textColor: Colors.white,
                  child: Text("Sign up".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                ) // Signup button
              ],
            ),
          ),
        ),
      ],
    );
  }

  void signUp() async {
    EasyLoading.show(status: 'loading...');
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      try {
        final currentUser = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email,
                password:
                    _password); // creates an instance in firebase authentication.
        var userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = _name;
        await currentUser.updateProfile(userUpdateInfo);
        await currentUser.reload();
        EasyLoading.dismiss();
        var doc = {
          'patient_email_address': _email,
          'address': _userAddress,
          'doctorname': _doctorName,
          'patient_name': _name,
          'age': _age
        };
        Firestore.instance.collection("userinfo").add(doc).then((value) => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()))
            }); // store the user information in cloud firestore.
      } catch (e) {
        EasyLoading.dismiss();
        if (e.message ==
            "The email address is already in use by another account.") {
          showAlertDialogAlreadyExist(context);
        }
      }
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
      EasyLoading.dismiss();
    }
  } // function signUp

  String validatePassword(String value) {
    if (value.length < 7)
      return 'Password must be more than 6 character';
    else
      return null;
  } //password validation

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  } // email validation

  String validateName(String value) {
    if (value.length < 2)
      return 'Name must be more than 3 character';
    else
      return null;
  } // name validation

  String validateAddress(String value) {
    if (value.length < 2)
      return 'Address must be more than 10 character';
    else
      return null;
  } // address validation
}

showAlertDialogAlreadyExist(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sign Up Failed"),
    content: Text("User already exists"),
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
} // alert dialog box

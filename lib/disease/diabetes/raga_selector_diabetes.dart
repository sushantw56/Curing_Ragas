import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/disease/diabetes/bageshri_songs.dart';
import 'package:ragaviz/disease/diabetes/chandrakauns_songs.dart';
import 'package:ragaviz/disease/diabetes/ganamurti_songs.dart';
import 'package:ragaviz/disease/diabetes/puriya_dhanashree_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RagaSelectorDiabetes extends StatefulWidget {
  @override
  _RagaSelectorDiabetesState createState() => _RagaSelectorDiabetesState();
}

class _RagaSelectorDiabetesState extends State<RagaSelectorDiabetes> {
  var records = [];
  var _name;
  var _email;

  @override
  void initState() {
    getMyRecords1();
    getMyRecords2();
    getMyRecords3();
    getMyRecords4();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFf5f5f2),
        appBar: new AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF004761),
              )),
          backgroundColor: Color(0xFFf5f5f2),
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              MaterialButton(
                height: 40.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BageshriSongs()));
                  saveDataBageshri();
                },
                child: Text('Raga Bageshri', style: TextStyle(fontSize: 20)),
                color: Color(0xFF004761),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
                elevation: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Raga Information : It is a popular raga of the late night, it is said to have been first sung by Mian Tansen, the celebrated court singer of the Emperor Akbar in the sixteenth century. Used in treatment of diabetes.\nBest Time to listen : 9pm to 12am.\nPeriod of Listening : 15 min.',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Source Sans Pro'),
                  ),
                ),
              ),
              Divider(
                color: Colors.teal.shade900,
                height: 10,
                thickness: 2,
                indent: 9,
                endIndent: 9,
              ),
              MaterialButton(
                height: 40.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChandrakaunsSongs()));
                  saveDataChandrakauns();
                },
                child:
                    Text('Raga Chandrakauns', style: TextStyle(fontSize: 20)),
                color: Color(0xFF004761),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
                elevation: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Raga Information : Chandrakauns is a raga in Hindustani classical music. It is also used in tail pieces and lighter presentations of Carnatic music.\nBest Time to listen : 9pm to 12am.\nPeriod of Listening : 15 min.',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Source Sans Pro'),
                  ),
                ),
              ),
              Divider(
                color: Colors.teal.shade900,
                height: 10,
                thickness: 2,
                indent: 9,
                endIndent: 9,
              ),
              MaterialButton(
                height: 40.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GanamurtiSongs()));
                  saveDataGanamurti();
                },
                child: Text('Raga Ganamurti', style: TextStyle(fontSize: 20)),
                color: Color(0xFF004761),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Raga Information : Ganamurti (pronounced gānamūrti, meaning the idol of music) is a rāgam in Carnatic music (musical scale of South Indian classical music). It is the 3rd Melakarta rāgam in the 72 melakarta rāgam system of Carnatic music. It is called Gānasāmavarāḷi in Muthuswami Dikshitar school of Carnatic music.\nBest Time to listen : 4pm to 7pm.\nPeriod of Listening : 15 min.',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Source Sans Pro'),
                  ),
                ),
              ),
              Divider(
                color: Colors.teal.shade900,
                height: 10,
                thickness: 2,
                indent: 9,
                endIndent: 9,
              ),
              MaterialButton(
                height: 40.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PuriyaDhanashreeSongs()));
                  saveDataPuriyaDhanashree();
                },
                child: Text('Raga Puriya Dhanashree',
                    style: TextStyle(fontSize: 20)),
                color: Color(0xFF004761),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Raga Information : Puriya Dhanashree is a raga in Hindustani classical music. It belongs to the Poorvi Thaat and has been derived from the Janak raga.\nBest Time to listen : 4pm to 7pm.\nPeriod of Listening : 15 min.',
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'Source Sans Pro'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userEmailAddress') ?? "xyz@gmail.com";
    return name;
  }

  Future getMyRecords1() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragabageshri")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataBageshri() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragabageshri").add(doc);
  }

  Future getMyRecords2() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragachandrakauns")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataChandrakauns() {
    var doc = {
      'email': _email,
      'name': _name,
      'notedOn': new DateTime.now().toUtc()
    };
    Firestore.instance.collection("ragachandrakauns").add(doc);
  }

  Future getMyRecords3() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragapuriyadhanshree")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataPuriyaDhanashree() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragapuriyadhanshree").add(doc);
  }

  Future getMyRecords4() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragaganamurti")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataGanamurti() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragaganamurti").add(doc);
  }
}

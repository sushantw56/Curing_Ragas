import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/disease/diabetes/puriya_dhanashree_songs.dart';
import 'package:ragaviz/disease/highbp/ahir_bhairav_songs.dart';
import 'package:ragaviz/disease/highbp/bhupali_songs.dart';
import 'package:ragaviz/disease/highbp/todi_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RagaSelectorHighBP extends StatefulWidget {
  @override
  _RagaSelectorHighBPState createState() => _RagaSelectorHighBPState();
}

class _RagaSelectorHighBPState extends State<RagaSelectorHighBP> {
  var records = [];

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
                      MaterialPageRoute(builder: (context) => TodiSongs()));
                  saveDataTodi();
                },
                child: Text('Raga Todi', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Miyan ki Todi, often simply referred to as Todi (IAST: Tōḍi), is a Hindustani classical raga which gave its name to the Todi thaat, one of the ten types of classical music according to the musicologist Bhatkhande.It gives tremendous relief to patients of high blood pressure.\nBest Time to listen : 8am to 10am.\nPeriod of Listening : 20 min.',
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
                          builder: (context) => AhirBhairavSongs()));
                  saveDataAhirBhairav();
                },
                child:
                    Text('Raga Ahir-Bhairav', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Ahir Bhairav is a Hindustani classical raga. It is a mixture of Bhairav and the ancient, rare raga Ahiri or Abhiri, or perhaps a mixture of Bhairav and Kafi.\nBest Time to listen : 6am to 9am.\nPeriod of Listening : 15 min.',
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BhupaliSongs()));
                  saveDataBhupali();
                },
                child: Text('Raga Bhupali', style: TextStyle(fontSize: 20)),
                color: Color(0xFF004761),
                textColor: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Raga Information : Bhoopali, also known as Bhoop, Bhopali or Bhupali, (Hin: भूपाली / भोपाली) is a Hindustani classical raga. It is a pentatonic scale (uses 5 notes in ascending and descending scale). Most of the songs in this raga are based on Bhakti rasa. Since it uses 5 notes, belongs to the "Audav jaati" of ragas.\nBest Time to listen : 7pm to 10pm.\nPeriod of Listening : 15 min.',
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
                  saveDataPuriyaDhanashreehbp();
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
        .collection("ragatodi")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataTodi() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragatodi").add(doc);
  }

  Future getMyRecords2() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragaahirbhairav")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataAhirBhairav() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragaahirbhairav").add(doc);
  }

  Future getMyRecords3() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragabhupali")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataBhupali() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragabhupali").add(doc);
  }

  Future getMyRecords4() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragapuriyadhanashreehbp")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataPuriyaDhanashreehbp() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragapuriyadhanshreehbp").add(doc);
  }
}

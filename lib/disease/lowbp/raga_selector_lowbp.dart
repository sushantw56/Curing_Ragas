import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/disease/lowbp/asawari_songs.dart';
import 'package:ragaviz/disease/lowbp/malkauns_songs.dart';
import 'package:ragaviz/disease/lowbp/vasanti_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RagaSelectorLowBP extends StatefulWidget {
  @override
  _RagaSelectorLowBPState createState() => _RagaSelectorLowBPState();
}

class _RagaSelectorLowBPState extends State<RagaSelectorLowBP> {
  var records = [];

  var _email;

  @override
  void initState() {
    getMyRecords1();
    getMyRecords2();
    getMyRecords3();
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
                      MaterialPageRoute(builder: (context) => MalkaunsSongs()));
                  saveDataMalkauns();
                },
                child: Text('Raga Malkauns', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : It is supposed to sustain chords which automatically brings down blood pressure, helps to cure low blood pressure.\nBest Time to listen : 12am to 3am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => AsawariSongs()));
                  saveDataAsawari();
                },
                child: Text('Raga Asawari', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : This is a very sweet morning Raag which is also referred to as Asawari Todi. It is similar to Raag Bilaskhani Todi except that in Aaroh, instead of Madhyam and Nishad Varjya, Gandhar and Nishad are Varjya. The Avroh is same with Pancham Varjya in both the Raags.\nBest Time to listen : 7am – 10am.\nPeriod of Listening : 15 min.',
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
                      MaterialPageRoute(builder: (context) => VasantiSongs()));
                  saveDataVasanti();
                },
                child: Text('Raga Vasanta/Vasanti',
                    style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Vasantha (pronounced vasantā) is a raga in Carnatic music (musical scale of South Indian classical music). It is a janya raga of Suryakantam, the 17th Melakarta raga. According to P|Subba Rao, majority opinion is that the raga is derived from Mayamalavagowla, the 15th Melakarta raga.\nBest Time to listen : 7am – 10am.\nPeriod of Listening : 15 min.',
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
        .collection("ragamalkauns")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataMalkauns() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragamalkauns").add(doc);
  }

  Future getMyRecords2() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragaasawari")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataAsawari() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragaasawari").add(doc);
  }

  Future getMyRecords3() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragavasanti")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataVasanti() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragavasanti").add(doc);
  }
}

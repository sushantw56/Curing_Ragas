import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ragaviz/disease/stress/darbari_songs.dart';
import 'package:ragaviz/disease/stress/hindol_songs.dart';
import 'package:ragaviz/disease/stress/kedaram_songs.dart';
import 'package:ragaviz/disease/stress/marwa_songs.dart';
import 'package:ragaviz/disease/stress/nilambari_songs.dart';
import 'package:ragaviz/disease/stress/shree_songs.dart';
import 'package:ragaviz/disease/stress/yaman_songs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RagaSelectorStress extends StatefulWidget {
  @override
  _RagaSelectorStressState createState() => _RagaSelectorStressState();
}

class _RagaSelectorStressState extends State<RagaSelectorStress> {
  var records = [];

  var _email;

  @override
  void initState() {
    getMyRecords1();
    getMyRecords2();
    getMyRecords3();
    getMyRecords4();
    getMyRecords5();
    getMyRecords6();
    getMyRecords7();
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
                      MaterialPageRoute(builder: (context) => DarbariSongs()));
                  saveDataDarbari();
                },
                child: Text('Raga Darbari', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : It is considered very effective in easing tension.It is said to have been first sung by Mian Tansen, the celebrated court singer of the Emperor Akbar in the sixteenth century.\nBest Time to listen : 10pm to 1am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => HindolSongs()));
                  saveDataHindol();
                },
                child: Text('Raga Hindol', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Hindol is a Hindustani classical raga.The raga emerges from Kalyan thaat. It is an ancient raga associated with the spring season. The raga is to be sung or played on an instrument such as veena, sitar, sehnai, flute, etc.,during the first part of the day.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => ShreeSongs()));
                  saveDataShree();
                },
                child: Text('Raga Shree', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Shri ragam is an ancient ragam in the Carnatic tradition. It is also written as Sri or Shree. This scale does not have all the seven swaras (musical notes) in the ascending scale. Shree is the asampurna melakartha equivalent of Kharaharapriya, the 22nd Melakarta rāgam. It is the last of the 5 Ghana rāgams of Carnatic music.[1] It is a popular rāgam that is considered to be highly auspicious.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => YamanSongs()));
                  saveDataYaman();
                },
                child: Text('Raga Yaman', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Yaman emerged from the parent musical scale of Kalyan. Considered to be one of the most fundamental ragas in Hindustani tradition, it is thus often one of the first ragas taught to students.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => MarwaSongs()));
                  saveDataMarwa();
                },
                child: Text('Raga Marwa', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Marva or Marwa (IAST: Mārvā) is a hexatonic Indian raga; Pa (the fifth tone) is omitted. Marva is the eponymous raga of the Marva thaat.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
                      MaterialPageRoute(builder: (context) => KedaramSongs()));
                  saveDataKedaram();
                },
                child: Text('Raga Kedaram', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : Kedaram (pronounced kēdāram) is a rāgam in Carnatic music (musical scale of South Indian classical music). It is a derived scale (janya rāgam) from Shankarabharanam, the 29th Melakarta rāgam. Kedaram is similar to Natbehag of Hindustani classical music. The Kedar of Hindustani music belongs to Kalyan thaat and is quite different from Kedaram.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
                          builder: (context) => NilambariSongs()));
                  saveDataNilambari();
                },
                child: Text('Raga Nilambari', style: TextStyle(fontSize: 20)),
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
                    'Raga Information : It is a janya raga, derived from Dhirashankarabharanam, 29th of the Melakarta scale. Neelambari is an ancient raga mentioned in old treatises in music. It has vakra-prayogam (zig-zag) in both aarohanam and avarohanam. It is not related to the raga of the same name in Hindustani music.\nBest Time to listen : 3am to 7am.\nPeriod of Listening : 20 min.',
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
        .collection("ragadarbari")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataDarbari() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragadarbari").add(doc);
  }

  Future getMyRecords2() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragahindol")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataHindol() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragahindol").add(doc);
  }

  Future getMyRecords3() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragashree")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataShree() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragashree").add(doc);
  }

  Future getMyRecords4() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragayaman")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataYaman() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragayaman").add(doc);
  }

  Future getMyRecords5() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragamarwa")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataMarwa() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragamarwa").add(doc);
  }

  Future getMyRecords6() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("ragakedaram")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataKedaram() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("ragakedaram").add(doc);
  }

  Future getMyRecords7() async {
    _email = await _getThingsOnStartup();
    Firestore.instance
        .collection("raganilambari")
        .where("email", isEqualTo: _email)
        .orderBy("notedOn", descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        records = event.documents;
      });
    });
  }

  saveDataNilambari() {
    var doc = {'email': _email, 'notedOn': new DateTime.now().toUtc()};
    Firestore.instance.collection("raganilambari").add(doc);
  }
}

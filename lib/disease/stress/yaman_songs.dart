import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';
import 'package:ragaviz/disease/player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 =
    'https://drive.google.com/uc?export=view&id=1PdR7FNhqLNjxDyuunwFENFvIg2fFBqlE';
const kUrl2 =
    'https://drive.google.com/uc?export=view&id=1g4UI67yjBLY166Vukyql47ltTziVlgkb';
const kUrl3 =
    'https://drive.google.com/uc?export=view&id=1TpBKetaRMstdkfCb5L5AuDofjMNhylwj';
const kUrl4 =
    'https://drive.google.com/uc?export=view&id=1veq1xT3XXpJVDkUXPMLPZ20sKp-H3Avc';
const kUrl5 =
    'https://drive.google.com/uc?export=view&id=1q3KJIVmi_jvDZN1luC54-P40waJ6I-l7';
const kUrl6 =
    'https://drive.google.com/uc?export=view&id=1qlvGwveY2cFUL6zzaMXeh_w1988Or1tY';
const kUrl7 =
    'https://drive.google.com/uc?export=view&id=1xmc2fbKVjhHs_25SPivOC-gng254vDE6';
const kUrl8 =
    'https://drive.google.com/uc?export=view&id=1to27CqjIeDIgFGenadKWgzrYwlD43gc2';

class YamanSongs extends StatefulWidget {
  @override
  _YamanSongsState createState() => _YamanSongsState();
}

class _YamanSongsState extends State<YamanSongs> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  Widget remoteUrl() {
    return SingleChildScrollView(
      child: _Tab(children: [
        Text(
          'Raga Name : Yaman.                                                    ',
          style: TextStyle(fontSize: 20, fontFamily: 'Source Sans Pro'),
        ),
        Text(
          'The songs containing this ragas are as follows :                                  ',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Raag: Raag Yaman | Pandit Ram Deshpande',
          key: Key('url1'),
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Raag: Choo Lene Do Najuk Hothon | Kaajal | Mohammed Rafi',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Raag: Tere Husn Ki Kya Tarif Karun | Leader | Mohammed Rafi & Lata Mangeshkar',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl3),
        Text(
          'Raag: Ghar Se Nikalte Hi | Papa Kehte Hai | Udit Narayan',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl4),
        Text(
          'Raag: Kay Sera Sera | Pukar | Kavita Krishnamurthy & Shankar Mahadevan',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl5),
        Text(
          'Raag: Breathless | Shankar Mahadevan',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl6),
        Text(
          'Raag: Laal Ishq | Goliyon Ki Rasleela Ram-Leela | Arijit Singh',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl7),
        Text(
          'Raag: Aaj Ibaadat | Bajirao Mastani | Shreyas Puranik, Javed Bashir, Shadab Faridi, Shashi Suman & Altamash Faridi',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl8),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Duration>.value(
            initialData: Duration(),
            value: advancedPlayer.onAudioPositionChanged),
      ],
      child: DefaultTabController(
          length: 5,
          child: Stack(children: <Widget>[
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
                    )),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[],
                title: Text(
                  "Stress Curing Music",
                  style: TextStyle(color: Color(0xFF004761)),
                ),
              ),
              body: remoteUrl(),
            ),
          ])),
    );
  }
}

class _Tab extends StatelessWidget {
  final List<Widget> children;

  const _Tab({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final String txt;
  final VoidCallback onPressed;

  const _Btn({Key key, this.txt, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed));
  }
}

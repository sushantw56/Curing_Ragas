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
    'https://drive.google.com/uc?export=view&id=1dAbAZakNKYszUf5uVTxnEZlH4r7Jgsve';
const kUrl2 =
    'https://drive.google.com/uc?export=view&id=1TNCsGqtjfevqlNSyDJUVTEV0WEB6cN38';
const kUrl3 =
    'https://drive.google.com/uc?export=view&id=17qcDMd16PYaz-T_wbFD-g0GbosX9ihpP';

class HindolSongs extends StatefulWidget {
  @override
  _HindolSongsState createState() => _HindolSongsState();
}

class _HindolSongsState extends State<HindolSongs> {
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
          'Raga Name : Hindol.                                                    ',
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
          'Raag: Raag Hindol | Ustad Rashid Khan',
          key: Key('url1'),
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Raag: Ek Ladki Thi | Love You Hamesha | Kavita Krishnamurthy',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Raag: Innisai | Varalaru | Naresh Iyer',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl3),
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

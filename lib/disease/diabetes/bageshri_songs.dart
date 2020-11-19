import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: implementation_imports
import 'package:flutter/src/foundation/constants.dart';
import 'package:ragaviz/disease/player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 =
    'https://drive.google.com/uc?export=view&id=1eSZPUNmk-wrABO-hw0-OdZZJ7U_KXGfL';
const kUrl2 =
    'https://drive.google.com/uc?export=view&id=17sqcjVVMwk9QxVjucebZoExg8KXmvaiw';
const kUrl3 =
    'https://drive.google.com/uc?export=view&id=1Bf-SKehT1JoTqdGmDAyAQOOANhqQrHb-';
const kUrl4 =
    'https://drive.google.com/uc?export=view&id=17ebUEYD-8n_XRtB2r9VsdreItUL_Wz-l';

class BageshriSongs extends StatefulWidget {
  @override
  _BageshriSongsState createState() => _BageshriSongsState();
}

class _BageshriSongsState extends State<BageshriSongs> {
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
          'Raga Name : Bageshri.                                                    ',
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
          'Raag: Raag Bageshri in the Maharashtra Desert | Ramakant Gaikwad | Patiala Khayal | Music of India',
          key: Key('url1'),
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Raag: Bhageshwari Raga - Diabetes & Hypoglycemia | Therapeutic Ragas',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Raag: Aaja Re Pardesi Main - Madhumati Songs - Dilip Kumar - Vyjayantimala - Lata Mangeshkar',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl3),
        Text(
          'Raag: Jeevan Se Bhari Teri Aankhen | Kishore Kumar | Safar 1970 Songs | Rajesh Khanna',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl4),
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
                  "Diabetes Curing Music",
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

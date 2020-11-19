import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/constants.dart';

import 'package:ragaviz/disease/player_widget.dart';

typedef void OnError(Exception exception);

const kUrl1 =
    'https://drive.google.com/uc?export=view&id=1E2ZUz-ceYaTpJ_Ca4DNU6JV7Nya_RppC';
const kUrl2 =
    'https://drive.google.com/uc?export=view&id=1B_RHd94YVEAPKWuvynoIN1o4QXkGyqZy';
const kUrl3 =
    'https://drive.google.com/uc?export=view&id=1GWhOZf1TRF3BZkUEue-pILYVEZU4Xzu_';
const kUrl4 =
    'https://drive.google.com/uc?export=view&id=14smkm2id72_jGwZ0PnB2Tdr8ix0PnDNl';

class PuriyaDhanashreeSongs extends StatefulWidget {
  @override
  _PuriyaDhanashreeSongsState createState() => _PuriyaDhanashreeSongsState();
}

class _PuriyaDhanashreeSongsState extends State<PuriyaDhanashreeSongs> {
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
          'Raga Name : Puriya Dhanashree.                                                    ',
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
          'Raag: Raag Puriya Dhanashree | Parveen Sultana | Darbar Festival',
          key: Key('url1'),
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Raag: Chand Matala - Laal Ishq | Swapnil Bandodkar | Vaishali Samant',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Raag: Hai Rama - Rangeela | Hariharan | Swarnalatha',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl3),
        Text(
          'Raag: Ruth Aa Gayi Re - 1947 Earth | Sukhwinder Singh',
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

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
    'https://drive.google.com/uc?export=view&id=1-2Er2_xBoARM_V6DcpZrzsF6uPpJ0epS';
const kUrl2 =
    'https://drive.google.com/uc?export=view&id=1VhGnYyqLrTaQFyn-UY_yWftAgiq3TzuZ';
const kUrl3 =
    'https://drive.google.com/uc?export=view&id=19Vvqq3glKfZRTetxbrTBmMMptEwH82se';
const kUrl4 =
    'https://drive.google.com/uc?export=view&id=1KNoGCZYRxM2EWNSG5cwkxaiz8VmqAvrh';
const kUrl5 =
    'https://drive.google.com/uc?export=view&id=1oL6lULmV0cWfQJ6LjXDvOY5kCxrTUal7';
const kUrl6 =
    'https://drive.google.com/uc?export=view&id=1aT_y6XKhd5zxdwot1OiiWeS3pJTwGuoz';
const kUrl7 =
    'https://drive.google.com/uc?export=view&id=1icLwG_L0A2S87qKZKfUn5T4E9sLCxobq';
const kUrl8 =
    'https://drive.google.com/uc?export=view&id=1VZ4Iio39D-Zhp1sMLCRvITMOWrm-FKWT';

class KedaramSongs extends StatefulWidget {
  @override
  _KedaramSongsState createState() => _KedaramSongsState();
}

class _KedaramSongsState extends State<KedaramSongs> {
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
          'Raga Name : Kedaram.                                                    ',
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
          'Raag: Raag Kedar | Suchismita Das',
          key: Key('url1'),
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl1),
        Text(
          'Raag: Aap Ki Ankhon Mein Kuch | Ghar | Lata Mangeshkar & Kishore Kumar',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl2),
        Text(
          'Raag: Aap Yun Hi Agar Humse Milte Rahe | Ek Musafir Ek Hasina | Mohammed Rafi & Asha Bhosle',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl3),
        Text(
          'Raag: Kisi Ki Yaad Mein | Jahan Ara | Mohammed Rafi',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl4),
        Text(
          'Raag: Pal Do Pal Ka Saath Hamara | The Burning Train | Mohammed Rafi & Asha Bhosle',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl5),
        Text(
          'Raag: Humko Mann Ki Shakti Dena | Tribute to Victims of 2008 | A R Rahman',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl6),
        Text(
          'Raag: Bekas Pe Karam Kijiye | Mughal-e-Azam | Lata Mangeshkar',
          style: TextStyle(fontSize: 20),
        ),
        PlayerWidget(url: kUrl7),
        Text(
          'Raag: Bekas Pe Karam Kijiye | Ali Zafar ',
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertp/music.dart';
import 'package:fluttertp/data.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(),
      home: const MyHomePage(title: 'YNOVIFY'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Variables Music player
  final _player = AudioPlayer();
  bool icon = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _player.setAsset(MyMusicList[count].urlSong);
  }

  void play() {
    _player.play();
  }

//Function play pause music
  void check() {
    if (icon = icon) {
      _player.play();
    } else {
      _player.pause();
    }
  }

  //Function skip music player
  void skip(int SkipOrPass) {
    setState(() {
      count += SkipOrPass;
      if (count < 0) {
        count = 0;
      } else if (count > MyMusicList.length - 1) {
        count = MyMusicList.length - 1;
      } else {
        _init();
      }
    });
  }

//Widget Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(widget.title),
          ),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 159, 15, 195),
                Color.fromARGB(255, 39, 37, 4),
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(MyMusicList[count].imagePath),
                SizedBox(height: 20),
                Text(
                  MyMusicList[count].title,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 15),
                Text(
                  MyMusicList[count].singer,
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                SizedBox(height: 20),

                //Button en Row skip play pause music
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.skip_previous_sharp),
                      onPressed: () {
                        skip(-1);
                      },
                      color: Color.fromARGB(255, 0, 0, 0),
                      iconSize: 40,
                    ),
                    IconButton(
                      icon: (icon)
                          ? new Icon(Icons.pause_circle)
                          : new Icon(Icons.play_circle),
                      onPressed: () {
                        setState(() {
                          icon = !icon;
                        });
                        check();
                      },
                      color: Color.fromARGB(255, 0, 0, 0),
                      iconSize: 40,
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next_sharp),
                      onPressed: () {
                        skip(1);
                      },
                      color: Color.fromARGB(255, 0, 0, 0),
                      iconSize: 40,
                    ),
                  ],
                ),

                //Duration music player
                StreamBuilder(
                    stream: _player.durationStream,
                    builder: (context, asyncSnapshot) {
                      final Object? duration = asyncSnapshot.data;
                      return Text(
                        duration.toString(),
                        style: const TextStyle(
                            fontSize: 21,
                            color: Color.fromARGB(255, 247, 54, 118)),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}

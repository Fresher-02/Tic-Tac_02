import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:soundpool/soundpool.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> content = [" ", " ", " ", " ", " ", " ", " ", " ", " "];
  bool turn = true;
  int full = 1;
  int score1 = 0;
  int score2 = 0;
  int switch1 = 0;
  Soundpool pool = Soundpool(streamType: StreamType.notification);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 10,
        title: Text(
          "TIC-TAC-TOE",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.black,
              Colors.black87,
            ])),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: Text(
                          "PLAYER-O",
                          style: TextStyle(
                              fontSize: 25, color: Colors.yellowAccent),
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        child: Text("$score2",
                            style: TextStyle(
                                fontSize: 22, color: Colors.yellowAccent)),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        child: Text("PLAYER-X",
                            style: TextStyle(
                                fontSize: 25, color: Colors.yellowAccent)),
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        child: Text("$score1",
                            style: TextStyle(
                                fontSize: 22, color: Colors.yellowAccent)),
                        alignment: Alignment.center,
                      ),
                    ],
                  )
                ],
              ),
            )),
            Expanded(
              flex: 4,
              child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        tapped(index);
                        int soundId = await rootBundle
                            .load("assets/click.m4a")
                            .then((ByteData soundData) {
                          return pool.load(soundData);
                        });
                        int streamId = await pool.play(soundId);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white24,
                                offset: Offset(3.0, 3.0),
                                // spreadRadius: 3,
                                blurRadius: 1),
                            BoxShadow(
                                color: Colors.white30,
                                offset: Offset(-2.0, -2.0),
                                // spreadRadius: 3,
                                blurRadius: 1)
                          ],
                          color: Colors.yellow,
                          // border: Border.all(
                          // width: 2,
                          // color: Colors.black,
                          // )
                        ),
                        child: Center(
                          child: Text(
                            // index.toString(),
                            content[index],
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
                child: Container(
              child: Center(
                child: GestureDetector(
                  onTap: () async {
                    int soundId = await rootBundle
                        .load("assets/replay.m4a")
                        .then((ByteData soundData) {
                      return pool.load(soundData);
                    });
                    int streamId = await pool.play(soundId);
                    setState(() {
                      for (int i = 0; i < 9; i++) {
                        content[i] = " ";
                      }
                      full = 0;
                      score1 = score2 = 0;
                      // turn = true;
                      // player.play("assets/replay.mp3");
                    });
                  },
                  child: Text(
                    "sushant@developer",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Colors.white24),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  tapped(int index) {
    full = full + 1;
    setState(() {
      if (turn) {
        content[index] = "O";
      } else {
        content[index] = "X";
      }
      turn = !turn;
      check();
    });
  }

  // doubletapped(int index) {
  //   setState(() {
  //     content[index] = " ";
  //   });
  // }

  check() {
    if (content[0] == content[1] &&
        content[0] == content[2] &&
        content[0] != " ") {
      winner(content[0]);
    }
    if (content[3] == content[4] &&
        content[3] == content[5] &&
        content[3] != " ") {
      winner(content[3]);
    }
    if (content[6] == content[7] &&
        content[6] == content[8] &&
        content[6] != " ") {
      winner(content[6]);
    }
    if (content[0] == content[3] &&
        content[0] == content[6] &&
        content[0] != " ") {
      winner(content[0]);
    }
    if (content[1] == content[4] &&
        content[1] == content[7] &&
        content[1] != " ") {
      winner(content[1]);
    }
    if (content[2] == content[5] &&
        content[2] == content[8] &&
        content[2] != " ") {
      winner(content[2]);
    }
    if (content[0] == content[4] &&
        content[0] == content[8] &&
        content[0] != " ") {
      winner(content[0]);
    }
    if (content[2] == content[4] &&
        content[2] == content[6] &&
        content[2] != " ") {
      winner(content[2]);
    } else if (full == 9) {
      // reset();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ITS A DRAW"),
              actions: [
                TextButton(
                    onPressed: () async {
                      setState(() {
                        for (int i = 0; i < 9; i++) {
                          content[i] = " ";
                        }
                      });
                      int soundId = await rootBundle
                          .load("assets/restart.m4a")
                          .then((ByteData soundData) {
                        return pool.load(soundData);
                      });
                      int streamId = await pool.play(soundId);
                      full = 0;
                      // turn = true;

                      Navigator.of(context).pop();
                    },
                    child: Text("play again"))
              ],
            );
          });
    }
  }

  winner(x) {
    if (x == "X" && full != 9) {
      score1 += 1;
    } else if (x == "O" && full != 9) {
      score2 += 1;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          
          return AlertDialog(
            title: Text("WINNER IS " + x),
            actions: [
              TextButton(
                  onPressed: () async {
                    int soundId = await rootBundle
                        .load("assets/restart.m4a")
                        .then((ByteData soundData) {
                      return pool.load(soundData);
                    });
                    int streamId = await pool.play(soundId);
                    setState(() {
                      for (int i = 0; i < 9; i++) {
                        content[i] = " ";
                      }
                      full = 0;
                      // turn = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("restart"))
            ],
          );
          // }
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  int scoreO = 0;
  int scoreX = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.deepPurple,
              Colors.purpleAccent,
              Colors.purple,
              Colors.pink
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
                        height: 70,
                        width: 200,
                        child: Text(
                          "PLAYER-1",
                          style: TextStyle(fontSize: 30),
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        child: Text("score", style: TextStyle(fontSize: 30)),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 200,
                        child: Text("PLAYER-2", style: TextStyle(fontSize: 30)),
                        alignment: Alignment.bottomCenter,
                      ),
                      Container(
                        child: Text("score", style: TextStyle(fontSize: 30)),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
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
                child: Text(
                  "sushant@developer",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
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

  doubletapped(int index) {
    setState(() {
      content[index] = " ";
    });
  }

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
    } else if (full > 8) {
      // reset();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("ITS A DRAW"),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < 9; i++) {
                          content[i] = " ";
                        }
                      });
                      full = 0;
                      Navigator.of(context).pop();
                    },
                    child: Text("play again"))
              ],
            );
          });
    }
  }

  winner(x) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          if (full == 9) {
            return AlertDialog(
              title: Text("ITS A DRAW"),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < 9; i++) {
                        content[i] = " ";
                      }

                      full = 0;
                    });

                    Navigator.of(context).pop();
                  },
                  child: Text("restart"),
                )
              ],
            );
          } else {
            // print(full);
            return AlertDialog(
              title: Text("WINNER IS " + x),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        for (int i = 0; i < 9; i++) {
                          content[i] = " ";
                        }
                        full = 0;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("restart"))
              ],
            );
          }
        });
  }
}

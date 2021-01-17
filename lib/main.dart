import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

//test
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;

  void answerQuestion() {
    setState(() {
      questionIndex++;
    });
    print(questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("StarTracker"),
        ),
        body: Column(children: [
          RaisedButton(
            child: Text("Aan"),
            onPressed: answerQuestion,
          ),
          RaisedButton(
            child: Text("Traag"),
            onPressed: answerQuestion,
          ),
          RaisedButton(
            child: Text("Omhoog"),
            onPressed: answerQuestion,
          ),
        ]),
      ),
    );
  }
}

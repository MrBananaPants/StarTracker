import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var buttonIndex = 0;

  void buttonPressed() {
    setState(() {
      buttonIndex++;
    });
    print(buttonIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("StarTracker"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  child: Text('Aan'),
                  onPressed: buttonPressed,
                ),
                RaisedButton(
                  child: Text('Uit'),
                  onPressed: buttonPressed,
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text('Traag'),
                  onPressed: buttonPressed,
                ),
                RaisedButton(
                  child: Text('Snel'),
                  onPressed: buttonPressed,
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text('Omhoog'),
                  onPressed: buttonPressed,
                ),
                RaisedButton(
                  child: Text('Omlaag'),
                  onPressed: buttonPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

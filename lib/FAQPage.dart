import "package:flutter/material.dart";

class FAQPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("FAQ"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 13, right: 13, top: 20),
        child: Column(
          children: <Widget>[Text("FAQ")],
        ),
      ),
    );
  }
}

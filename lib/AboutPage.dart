import "package:flutter/material.dart";
//import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("Over"),
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(left: 13, right: 13, top: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Over deze app',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "Deze app is door Joran ontwikkeld voor zijn GIP StarTracker. Met deze app kan de StarTracker draadloos bediend worden.",
                            style: TextStyle(
                                //color: Colors.black.withOpacity(0.6),
                                ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'GitHub',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: GestureDetector(
                            child: Text(
                              "GitHub StarTracker",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              launch(
                                  "https://github.com/MrBananaPants/StarTracker");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "Versie: Pre-release v0.3",
                      style: TextStyle(
                          //color: Colors.black.withOpacity(0.6),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "Flutter: 1.22.6",
                      style: TextStyle(
                          //color: Colors.black.withOpacity(0.6),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Joran Vancoillie",
                      style: TextStyle(
                          //color: Colors.black.withOpacity(0.6),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

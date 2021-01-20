import "package:flutter/material.dart";
import 'package:http/http.dart';

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
  void buttonPressed() {
    String url = requestURL[requestURLIndex];
    get(url);
    print(requestURL);
  }

  var requestURLIndex = 0;
  var requestURL = [
    'http://192.168.4.1/StarTrackerMainAan',
    'http://192.168.4.1/StarTrackerMainUit',
    'http://192.168.4.1/SpeedTraag',
    'http://192.168.4.1/SpeedSnel',
    'http://192.168.4.1/RichtingOmhoog',
    'http://192.168.4.1/RichtingOmlaag',
  ];
  @override
  Widget build(BuildContext context) {
    final buttonGotPressed = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       //Make primary color that can be reused.
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF6200EE),
          label: Text("Reset"),
          icon: Icon(Icons.refresh),
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Color(0xFF6200EE),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  //Nothing yet...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  //Nothing yet...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Color(0xFF6200EE),
          title: Text("StarTracker"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 13, right:13, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Status',
                        ),
                      ),
                      ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: 150,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 0;
                              buttonPressed();
                            },
                            child: Text('AAN'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 1;
                              buttonPressed();
                            },
                            child: Text('UIT'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Snelheid',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      // ),
                      ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: 150,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 2;
                              buttonPressed();
                            },
                            child: const Text('TRAAG'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 3;
                              buttonPressed();
                            },
                            child: const Text('SNEL'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Richting',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      // ),
                      ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: 150,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 4;
                              buttonPressed();
                            },
                            child: const Text('OMHOOG'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF6200EE),
                            onPressed: () {
                              requestURLIndex = 5;
                              buttonPressed();
                            },
                            child: const Text('OMLAAG'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Title',
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      // ),
                      ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: 150,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: []
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
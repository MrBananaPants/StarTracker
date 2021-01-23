import 'package:condition/condition.dart';
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

  void changeStateToAAN() => buttonStatus = true;
  void changeStateToUIT() => buttonStatus = false;

  void changeStateToTRAAG() => buttonSnelheid = true;
  void changeStateToSNEL() => buttonSnelheid = false;

  void changeStateToOMHOOG() => buttonRichting = true;
  void changeStateToOMLAAG() => buttonRichting = false;

  void resetPressed() {
    get(requestURL[0]);
    get(requestURL[3]);
    get(requestURL[5]);

    buttonStatus = false;
    buttonSnelheid = true;
    buttonRichting = true;
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

  bool buttonStatus = true;
  bool buttonSnelheid = false;
  bool buttonRichting = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //Make primary color that can be reused.
          ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          //backgroundColor: Color(0xFF6200EE),
          backgroundColor: Color(0xFF3D5AFE),
          label: Text("Reset"),
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetPressed();

            setState(() {
              changeStateToUIT();
              changeStateToTRAAG();
              changeStateToOMHOOG();
            });
          },
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Color(0xFF3D5AFE),
                ),
              ),
              ListTile(
                title: Text('Home'),
                onTap: () {
                  //Nothing yet...
                },
              ),
              ListTile(
                title: Text('About'),
                onTap: () {
                  //Nothing yet...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 4,
          backgroundColor: Color(0xFF0031CA),
          title: Text("StarTracker"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 13, right: 13, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
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
                      Container(
                          child: Conditioned(cases: [
                        Case(buttonStatus == true,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('AAN'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToUIT();
                                          requestURLIndex = 0;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('UIT'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToAAN();
                                          requestURLIndex = 1;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                        Case(buttonStatus == false,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('AAN'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToUIT();
                                          requestURLIndex = 0;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('UIT'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToAAN();
                                          requestURLIndex = 1;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                      ], defaultBuilder: () => Text("Null value returned"))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
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
                      Container(
                          child: Conditioned(cases: [
                        Case(buttonSnelheid == true,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('TRAAG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToSNEL();
                                          requestURLIndex = 2;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('SNEL'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToTRAAG();
                                          requestURLIndex = 3;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                        Case(buttonSnelheid == false,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('TRAAG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToSNEL();
                                          requestURLIndex = 2;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('SNEL'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToTRAAG();
                                          requestURLIndex = 3;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                      ], defaultBuilder: () => Text("Null value returned"))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
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
                      Container(
                          child: Conditioned(cases: [
                        Case(buttonRichting == true,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('OMHOOG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToOMLAAG();
                                          requestURLIndex = 4;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('OMLAAG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToOMHOOG();
                                          requestURLIndex = 5;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                        Case(buttonRichting == false,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      child: const Text('OMHOOG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToOMLAAG();
                                          requestURLIndex = 4;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Text('OMLAAG'),
                                      onPressed: () {
                                        setState(() {
                                          changeStateToOMHOOG();
                                          requestURLIndex = 5;
                                          buttonPressed();
                                        });
                                      },
                                    ),
                                  ],
                                )),
                      ], defaultBuilder: () => Text("Null value returned"))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        'Weer & Timer',
                      ),
                    ),
                    ButtonBar(
                      buttonHeight: 40,
                      buttonMinWidth: 150,
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Color(0xFF3D5AFE),
                          onPressed: () {
                            requestURLIndex = 4;
                            buttonPressed();
                          },
                          child: const Text('TEST1'),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Color(0xFF3D5AFE),
                          onPressed: () {
                            requestURLIndex = 5;
                            buttonPressed();
                          },
                          child: const Text('TEST2'),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

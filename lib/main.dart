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

  void changeStateToTrue() {
    buttonGotPressed = true;
    testTextIndex = 0;
    print(buttonGotPressed);
  }

  void changeStateToFalse() {
    buttonGotPressed = false;
    testTextIndex = 1;
    print(buttonGotPressed);
  }

  var testTextIndex = 0;
  var testText = [
    'true',
    'false',
  ];
  var requestURLIndex = 0;
  var requestURL = [
    'http://192.168.4.1/StarTrackerMainAan',
    'http://192.168.4.1/StarTrackerMainUit',
    'http://192.168.4.1/SpeedTraag',
    'http://192.168.4.1/SpeedSnel',
    'http://192.168.4.1/RichtingOmhoog',
    'http://192.168.4.1/RichtingOmlaag',
  ];
  bool buttonGotPressed = false;

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
          onPressed: () {},
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
                              requestURLIndex = 0;
                              buttonPressed();
                            },
                            child: Text('AAN'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF3D5AFE),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      // ),
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
                              requestURLIndex = 2;
                              buttonPressed();
                            },
                            child: const Text('TRAAG'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF3D5AFE),
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
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      // ),
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
                            child: const Text('OMHOOG'),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            color: Color(0xFF3D5AFE),
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
                          testText[testTextIndex],
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text("Simulate State : "),
                      //     Switch(
                      //         value: buttonGotPressed,
                      //         onChanged: (bool valueChanged) {
                      //           setState(() {
                      //             buttonGotPressed = valueChanged;
                      //             print("Button State = $buttonGotPressed");
                      //           });
                      //         })
                      //   ],
                      // ),
                      Container(
                          child: Conditioned(cases: [
                        Case(buttonGotPressed == true,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth: 150,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        changeStateToFalse();
                                      },
                                      child: const Text('On'),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xFF3D5AFE),
                                      onPressed: () {
                                        changeStateToTrue();
                                      },
                                      child: const Text('Off'),
                                    ),
                                  ],
                                )),
                        Case(buttonGotPressed == false,
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
                                      onPressed: () {
                                        changeStateToFalse();
                                      },
                                      child: const Text('On'),
                                    ),
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      onPressed: () {
                                        changeStateToTrue();
                                      },
                                      child: const Text('Off'),
                                    ),
                                  ],
                                )),
                      ], defaultBuilder: () => Text("Null value returned"))),
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

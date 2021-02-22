import 'package:url_launcher/url_launcher.dart';
import 'package:condition/condition.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
//import 'SettingsPage.dart';
//import 'Snackbar.dart';
//import 'stopwatch.dart';
import 'FAQPage.dart';
import 'AboutPage.dart';
import 'dart:async';
//import 'package:weather/weather.dart';

// WeatherFactory wf = new WeatherFactory('40a5994694fe3f819ab0e809530381bc',
//     language: Language.DUTCH);
// String cityName = 'Brussel';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white10,
      ),
      darkTheme: ThemeData.dark(),
      home: BodyOfApp(),
    ),
  );
}

class BodyOfApp extends StatefulWidget {
  @override
  BodyOfAppState createState() => BodyOfAppState();
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

var appBarColor = 0;
var buttonColor = 1;
var themeColor = [
  0xFF0031CA,
  0xFF3D5AFE,
  0xFF004c40,
  0xFF00796b,
];

bool timerStatus = true;
bool buttonThema = true;

void setTimerToAAN() {
  timerStatus = true;
  buttonThema = false;
}

void setTimerToUIT() {
  timerStatus = false;
  buttonThema = true;
}

class BodyOfAppState extends State<BodyOfApp> {
  void buttonPressed() {
    String url = requestURL[requestURLIndex];
    get(url);
  }

  void changeStateToAAN() => buttonStatus = true;
  void changeStateToUIT() => buttonStatus = false;

  void changeStateToTRAAG() => buttonSnelheid = true;
  void changeStateToSNEL() => buttonSnelheid = false;

  void changeStateToOMHOOG() => buttonRichting = true;
  void changeStateToOMLAAG() => buttonRichting = false;

  Future<void> resetPressed() async {
    get(requestURL[0]);
    get(requestURL[3]);
    get(requestURL[5]);

    buttonStatus = false;
    buttonSnelheid = true;
    buttonRichting = true;

    //  Weather weather = await wf.currentWeatherByCityName(cityName);
    //  print(weather);
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

  int showBanner = 1;

  bool flag = true;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hoursStr = '00';
  String minutesStr = '00';
  String secondsStr = '00';

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  void changeTheme() {
    // String url = requestURL[requestURLIndex];
    // get(url);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(themeColor[appBarColor]),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "StarTracker",
            style: TextStyle(
                //color: Colors.black,
                ),
          ),
        ),
      ),
      body: ListView(
        children: [
          // LinearProgressIndicator(
          //   minHeight: 4.0,
          // ),
          // Text(
          //   'StarTracker',
          //   style: TextStyle(
          //     fontWeight: FontWeight.w400,
          //     letterSpacing: 1.1,
          //   ),
          // ),
          if (showBanner == 1)
            MaterialBanner(
              content: const Text(
                  'Deze app is nog in ontwikkeling. Er kunnen zich bugs voordoen.'),
              leading: CircleAvatar(
                child: Icon(Icons.error_outline),
              ),
              actions: [
                FlatButton(
                  child: const Text('INFO'),
                  onPressed: () {
                    launch("https://github.com/MrBananaPants/StarTracker");
                  },
                ),
                FlatButton(
                  child: const Text('SLUITEN'),
                  onPressed: () {
                    setState(
                      () {
                        showBanner = 0;
                      },
                    );
                  },
                ),
              ],
            ),
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
                      'Status',
                    ),
                  ),
                  Container(
                    child: Conditioned(
                        cases: [
                          Case(
                            buttonStatus == true,
                            builder: () => ButtonBar(
                              buttonHeight: 40,
                              buttonMinWidth:
                                  SizeConfig.blockSizeHorizontal * 38,
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlineButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text('AAN'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeStateToUIT();
                                        requestURLIndex = 0;
                                        buttonPressed();
                                      },
                                    );
                                    timerStream = stopWatchStream();
                                    timerSubscription = timerStream.listen(
                                      (int newTick) {
                                        setState(
                                          () {
                                            hoursStr =
                                                ((newTick / (60 * 60)) % 60)
                                                    .floor()
                                                    .toString()
                                                    .padLeft(2, '0');
                                            minutesStr = ((newTick / 60) % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                            secondsStr = (newTick % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Color(themeColor[buttonColor]),
                                  child: const Text('UIT'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeStateToAAN();
                                        requestURLIndex = 1;
                                        buttonPressed();
                                      },
                                    );
                                    timerSubscription.cancel();
                                    timerStream = null;
                                    setState(
                                      () {
                                        hoursStr = '00';
                                        minutesStr = '00';
                                        secondsStr = '00';
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Case(
                            buttonStatus == false,
                            builder: () => ButtonBar(
                              buttonHeight: 40,
                              buttonMinWidth:
                                  SizeConfig.blockSizeHorizontal * 38,
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Color(themeColor[buttonColor]),
                                  child: const Text('AAN'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeStateToUIT();
                                        requestURLIndex = 0;
                                        buttonPressed();
                                      },
                                    );
                                    timerStream = stopWatchStream();
                                    timerSubscription = timerStream.listen(
                                      (int newTick) {
                                        setState(
                                          () {
                                            hoursStr =
                                                ((newTick / (60 * 60)) % 60)
                                                    .floor()
                                                    .toString()
                                                    .padLeft(2, '0');
                                            minutesStr = ((newTick / 60) % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                            secondsStr = (newTick % 60)
                                                .floor()
                                                .toString()
                                                .padLeft(2, '0');
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                                OutlineButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Text('UIT'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeStateToAAN();
                                        requestURLIndex = 1;
                                        buttonPressed();
                                      },
                                    );
                                    timerSubscription.cancel();
                                    timerStream = null;
                                    setState(
                                      () {
                                        hoursStr = '00';
                                        minutesStr = '00';
                                        secondsStr = '00';
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                        defaultBuilder: () {
                          return Text("Null value returned");
                        }),
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
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 13, right: 13, top: 3),
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
                    child: Conditioned(
                      cases: [
                        Case(buttonSnelheid == true,
                            builder: () => ButtonBar(
                                  buttonHeight: 40,
                                  buttonMinWidth:
                                      SizeConfig.blockSizeHorizontal * 38,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlineButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      color: Color(themeColor[buttonColor]),
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
                                  buttonMinWidth:
                                      SizeConfig.blockSizeHorizontal * 38,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      color: Color(themeColor[buttonColor]),
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
                                        borderRadius: BorderRadius.circular(5),
                                      ),
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
                      ],
                      defaultBuilder: () => Text("Null value returned"),
                    ),
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
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 13, right: 13, top: 3),
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
                    child: Conditioned(
                      cases: [
                        Case(
                          buttonRichting == true,
                          builder: () => ButtonBar(
                            buttonHeight: 40,
                            buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlineButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
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
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Color(themeColor[buttonColor]),
                                child: const Text('OMLAAG'),
                                onPressed: () {
                                  setState(
                                    () {
                                      changeStateToOMHOOG();
                                      requestURLIndex = 5;
                                      buttonPressed();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Case(
                          buttonRichting == false,
                          builder: () => ButtonBar(
                            buttonHeight: 40,
                            buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
                            alignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Color(themeColor[buttonColor]),
                                child: const Text('OMHOOG'),
                                onPressed: () {
                                  setState(
                                    () {
                                      changeStateToOMLAAG();
                                      requestURLIndex = 4;
                                      buttonPressed();
                                    },
                                  );
                                },
                              ),
                              OutlineButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
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
                          ),
                        ),
                      ],
                      defaultBuilder: () => Text("Null value returned"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 15,
          // ),
          // Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   elevation: 4,
          //   clipBehavior: Clip.antiAlias,
          //   margin: EdgeInsets.only(left: 13, right: 13, top: 3),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10),
          //     child: Column(
          //       children: [
          //         ListTile(
          //           title: Text(
          //             'Timer',
          //           ),
          //         ),
          //         Container(
          //           child: Conditioned(
          //             cases: [
          //               Case(
          //                 timerStatus == true,
          //                 builder: () => Padding(
          //                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          //                   child: Text(
          //                     "$hoursStr:$minutesStr:$secondsStr",
          //                     style: TextStyle(
          //                       fontSize: 16.0,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               Case(timerStatus == false, builder: () => null),
          //             ],
          //             defaultBuilder: () => Text("Null value returned"),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 15,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 13, right: 13, top: 3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(children: [
                ListTile(
                  title: Text(
                    'Timer',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    "$hoursStr:$minutesStr:$secondsStr",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          // Card(
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //   elevation: 4,
          //   clipBehavior: Clip.antiAlias,
          //   margin: EdgeInsets.only(left: 13, right: 13, top: 3),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(horizontal: 10),
          //     child: Column(
          //       children: [
          //         ListTile(
          //           title: Text(
          //             'Snackbar',
          //           ),
          //         ),
          //         ButtonBar(
          //           buttonHeight: 40,
          //           buttonMinWidth: 150,
          //           alignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             RaisedButton(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(5),
          //               ),
          //               color: Color(0xFF3D5AFE),
          //               child: const Text('TOON SNACKBAR'),
          //               onPressed: () {
          //                 //action
          //               },
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          SizedBox(
            height: 200,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // shape: AutomaticNotchedShape(
        //   RoundedRectangleBorder(),
        //   StadiumBorder(
        //     side: BorderSide(),
        //   ),
        // ),
        elevation: 8.0,
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQPage(),
                      ),
                    );
                  }
                  if (value == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      ),
                    );
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('FAQ'),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text('Over'),
                    value: 1,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingsPage();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(themeColor[buttonColor]),
        label: Text(
          'Reset',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: () {
          if (buttonStatus != false) {
            timerStream = stopWatchStream();
            timerSubscription = timerStream.listen(
              (int newTick) {
                setState(
                  () {
                    hoursStr = ((newTick / (60 * 60)) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    minutesStr = ((newTick / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    secondsStr =
                        (newTick % 60).floor().toString().padLeft(2, '0');
                  },
                );
              },
            );
            // timerSubscription.cancel();
            // timerStream = null;
            // setState(
            //   () {
            //     hoursStr = '00';
            //     minutesStr = '00';
            //     secondsStr = '00';
            //   },
            // );
          }
          resetPressed();
          setState(
            () {
              changeStateToUIT();
              changeStateToTRAAG();
              changeStateToOMHOOG();
            },
          );
        },
      ),
    );
  }
}

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: MaterialApp(),
      ),
    );
  }
}

///////////////////////////
///////SETTINGS PAGE///////
///////////////////////////

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
}

//bool buttonThema = false;

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("Instellingen (niet functioneel)"),
      ),
      body: ListView(
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
                      'Timer',
                    ),
                  ),
                  Container(
                      child: Conditioned(cases: [
                    Case(
                      buttonThema == true,
                      builder: () => ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text('AAN'),
                            onPressed: () {
                              setState(() {
                                setTimerToAAN();
                              });
                            },
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xFF3D5AFE),
                            child: const Text('UIT'),
                            onPressed: () {
                              setState(
                                () {
                                  setTimerToUIT();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Case(buttonThema == false,
                        builder: () => ButtonBar(
                              buttonHeight: 40,
                              buttonMinWidth:
                                  SizeConfig.blockSizeHorizontal * 38,
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Color(0xFF3D5AFE),
                                  child: const Text('AAN'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        setTimerToAAN();
                                      },
                                    );
                                  },
                                ),
                                OutlineButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text('UIT'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        setTimerToUIT();
                                      },
                                    );
                                  },
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
    );
  }
}

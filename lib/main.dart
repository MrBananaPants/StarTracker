import 'package:condition/condition.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'SettingsPage.dart';
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
      theme: ThemeData(),
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("StarTracker"),
      ),
      body: ListView(
        children: [
          // LinearProgressIndicator(
          //   minHeight: 4.0,
          // ),
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
                            buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
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
                                color: Color(0xFF3D5AFE),
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
                        Case(buttonStatus == false,
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
                                      color: Color(0xFF3D5AFE),
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
                                                minutesStr =
                                                    ((newTick / 60) % 60)
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
                                  buttonMinWidth:
                                      SizeConfig.blockSizeHorizontal * 38,
                                  alignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
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
                                color: Color(0xFF3D5AFE),
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
                                color: Color(0xFF3D5AFE),
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
          //     child: Column(children: [
          //       ListTile(
          //         title: Text(
          //           'Timer',
          //         ),
          //       ),
          //       ButtonBar(
          //         buttonHeight: 40,
          //         buttonMinWidth: 150,
          //         alignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           RaisedButton(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5),
          //             ),
          //             color: Color(0xFF3D5AFE),
          //             onPressed: () {},
          //             child: const Text('START'),
          //           ),
          //           RaisedButton(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(5),
          //             ),
          //             color: Color(0xFF3D5AFE),
          //             onPressed: () {},
          //             child: const Text('STOP'),
          //           ),
          //         ],
          //       ),
          //     ]),
          //   ),
          // ),
          SizedBox(
            height: 40,
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
                  // SnackBar(
                  //   behavior: SnackBarBehavior.floating,
                  //   content: Text('Deze app is nog in ontwikkeling'),
                  //   action: SnackBarAction(
                  //     label: 'OK',
                  //     onPressed: () {},
                  //   ),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
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
        backgroundColor: Color(0xFF3D5AFE),
        label: Text(
          'Reset',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: () {
          resetPressed();
          setState(
            () {
              changeStateToUIT();
              changeStateToTRAAG();
              changeStateToOMHOOG();
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
        },
      ),
    );
  }
}

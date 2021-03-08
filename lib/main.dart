import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:condition/condition.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'SettingsPage.dart';
import 'FAQPage.dart';
import 'AboutPage.dart';
import 'dart:async';
import 'dart:ui';

const apiKey = '40a5994694fe3f819ab0e809530381bc';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          //Light theme data
          textTheme:
              TextTheme(bodyText2: TextStyle(color: Color(0xFF3D5AFE)), bodyText1: TextStyle(color: Colors.black), headline3: TextStyle(color: Colors.black)),
          scaffoldBackgroundColor: Color(0xFFf3f3f8),
          cardColor: Colors.white,
          shadowColor: Color(0xFFe2f1fd),
          iconTheme: IconThemeData(color: Colors.black),
          appBarTheme: AppBarTheme(color: Color(0xFFf3f3f8)),
          bottomAppBarColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3D5AFE), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
          outlinedButtonTheme:
              OutlinedButtonThemeData(style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF3D5AFE),
            shape: RoundedRectangleBorder(),
            textTheme: ButtonTextTheme.primary,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE))),
      darkTheme: ThemeData(
        //Dark theme data
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white), bodyText1: TextStyle(color: Colors.white), headline3: TextStyle(color: Colors.white)),

        scaffoldBackgroundColor: Color(0xFF2b2b2b),
        backgroundColor: Colors.black,
        cardColor: Color(0xFF454545),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(color: Color(0xFF2b2b2b)),
        bottomAppBarColor: Color(0xFF454545),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style:
                ElevatedButton.styleFrom(primary: Color(0xFF3D5AFE), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
        outlinedButtonTheme:
            OutlinedButtonThemeData(style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
        buttonTheme: ButtonThemeData(buttonColor: Color(0xFF3D5AFE), shape: RoundedRectangleBorder(), textTheme: ButtonTextTheme.primary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE)),
      ),
      home: BodyOfApp(),
    ),
  );
}

bool timerIsRunning = true;

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
    print(url);
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

  double latitude;
  double longitude;

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

  void startStopWatch() {}

  void getLocation() async {
    Position location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  String location = 'nog geen data';
  String description = '';
  var cloudCover = 0;
  var neerslag = 0;
  double temperatureValue = 0;
  var temperature = 0;

  void getData() async {
    Response response = await get('https://api.openweathermap.org/data/2.5/find?lat=$latitude&lon=$longitude&cnt=10&appid=$apiKey&units=metric&lang=nl');

    if (response.statusCode == 200) {
      String weatherData = response.body;
      print(weatherData);

      var decodedData = jsonDecode(weatherData);
      location = decodedData['list'][0]['name'];
      description = decodedData['list'][0]['weather'][0]['description'];
      cloudCover = decodedData['list'][0]['clouds']['all'];
      neerslag = decodedData['list'][0]['rain'];
      temperatureValue = decodedData['list'][0]['main']['temp'];

      if (neerslag == null) {
        neerslag = 0;
      }

      temperature = temperatureValue.round();
      print(location);
      print(temperature);
      print(cloudCover);
      print(description);
      print(neerslag);
      setState(() {});
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: false,
              expandedHeight: 80.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                title: Text(
                  'StarTracker',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontFamily: 'SF',
                  ),
                ),
                centerTitle: false,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(left: 13, right: 13, top: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Status',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Container(
                            child: Conditioned(
                              cases: [
                                Case(
                                  buttonStatus == true,
                                  builder: () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: Text(
                                            'AAN',
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText2.color,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(
                                              () {
                                                changeStateToUIT();
                                                requestURLIndex = 0;
                                                buttonPressed();
                                              },
                                            );
                                            if (timerStream == null) {
                                              timerStream = stopWatchStream();
                                              timerSubscription = timerStream.listen(
                                                (int newTick) {
                                                  setState(
                                                    () {
                                                      hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                                                      minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                                                      secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: Text(
                                            'UIT',
                                          ),
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
                                ),
                                Case(
                                  buttonStatus == false,
                                  builder: () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: const Text('AAN'),
                                          onPressed: () {
                                            setState(
                                              () {
                                                changeStateToUIT();
                                                requestURLIndex = 0;
                                                buttonPressed();
                                              },
                                            );
                                            if (timerStream == null) {
                                              timerStream = stopWatchStream();
                                              timerSubscription = timerStream.listen(
                                                (int newTick) {
                                                  setState(
                                                    () {
                                                      hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                                                      minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                                                      secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
                                                    },
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: Text(
                                            'UIT',
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText2.color,
                                            ),
                                          ),
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
                                ),
                              ],
                              defaultBuilder: () {
                                return Text("Null value returned");
                              },
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(left: 13, right: 13, top: 3),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Snelheid',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Container(
                            child: Conditioned(
                              cases: [
                                Case(buttonSnelheid == true,
                                    builder: () => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                                child: Text(
                                                  'TRAAG',
                                                  style: TextStyle(
                                                    color: Theme.of(context).textTheme.bodyText2.color,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    changeStateToSNEL();
                                                    requestURLIndex = 2;
                                                    buttonPressed();
                                                  });
                                                },
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
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
                                          ),
                                        )),
                                Case(buttonSnelheid == false,
                                    builder: () => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                                child: const Text('TRAAG'),
                                                onPressed: () {
                                                  setState(() {
                                                    changeStateToSNEL();
                                                    requestURLIndex = 2;
                                                    buttonPressed();
                                                  });
                                                },
                                              ),
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                                child: Text(
                                                  'SNEL',
                                                  style: TextStyle(
                                                    color: Theme.of(context).textTheme.bodyText2.color,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    changeStateToTRAAG();
                                                    requestURLIndex = 3;
                                                    buttonPressed();
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(left: 13, right: 13, top: 3),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Richting',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Container(
                            child: Conditioned(
                              cases: [
                                Case(
                                  buttonRichting == true,
                                  builder: () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: Text(
                                            'OMHOOG',
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText2.color,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              changeStateToOMLAAG();
                                              requestURLIndex = 4;
                                              buttonPressed();
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
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
                                ),
                                Case(
                                  buttonRichting == false,
                                  builder: () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
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
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: Text(
                                            'OMLAAG',
                                            style: TextStyle(
                                              color: Theme.of(context).textTheme.bodyText2.color,
                                            ),
                                          ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(left: 13, right: 13, top: 3),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        ListTile(
                          title: Text(
                            'Timer',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "$hoursStr:$minutesStr:$secondsStr",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 10,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(
                      left: 13,
                      right: 13,
                      top: 3,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              'Weer',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText2.color,
                              ),
                            ),
                            onPressed: () {
                              getLocation();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              'Locatie: $location',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Text(
                            'Beschrijving: $description',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          Text(
                            'Bewolking: $cloudCover%',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          Text(
                            'Neerslag: $neerslag%',
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              'Temperatuur: $temperature°C',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => FAQPage()),
                    );
                  }
                  if (value == 1) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => AboutPage()),
                    );
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text(
                      'FAQ',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Over',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                    ),
                    value: 1,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => SettingsPage()));
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
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
                    hoursStr = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
                    minutesStr = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
                    secondsStr = (newTick % 60).floor().toString().padLeft(2, '0');
                  },
                );
              },
            );
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

import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:condition/condition.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'SettingsPage.dart';
import 'AboutPage.dart';
import 'Stopwatch.dart';
import 'dart:convert';
import 'FAQPage.dart';
import 'Theme.dart';
import 'dart:ui';

const apiKey = '40a5994694fe3f819ab0e809530381bc';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
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
  }

  double latitude;
  double longitude;

  void getLocation() async {
    Position location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  String location = 'nog geen data';
  String description = '';
  var cloudCover = 0;
  int neerslag = 0;
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
                            'Neerslag: $neerslag mm',
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
                  if (value == 2) {
                    launch("https://github.com/MrBananaPants/StarTracker");
                  }
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "FAQ",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                      leading: Icon(
                        Icons.help,
                      ),
                    ),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Over",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                      leading: Icon(
                        Icons.info,
                      ),
                    ),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "GitHub",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                      leading: Icon(
                        Icons.link,
                      ),
                    ),
                    value: 2,
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

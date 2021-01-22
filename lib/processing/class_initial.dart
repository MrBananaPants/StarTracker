import 'package:http/http.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

double notch_cutout;

remove_Navigation_color()async{
  //Do some detection to determine has Notch or not//Simulate from Nokia 5.3 with Notch so 20 pixel is suitable
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await FlutterWindowManager.addFlags(
      FlutterWindowManager.FLAG_LAYOUT_NO_LIMITS);
}

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

bool buttonGotPressed = false;
bool connection = false;
bool speed_fast = false;
bool direction_up = false;
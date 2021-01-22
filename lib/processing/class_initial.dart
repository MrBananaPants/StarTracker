import 'package:http/http.dart';

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
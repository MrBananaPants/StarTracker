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

// class MyAppState extends State<MyApp> {
//   var questionIndex = 0;

//   void answerQuestion() {
//     setState(() {
//       questionIndex++;
//     });
//     print(questionIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var questions = [
//       "What's your favorite color?",
//       "What's your favorite animal?"
//     ];

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Color(0xFF6200EE),
            ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 4,
          leading: Icon(Icons.menu),
          backgroundColor: Color(0xFF6200EE),
          title: Text("StarTracker"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Status',
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  // ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          requestURLIndex = 0;
                          buttonPressed();
                        },
                        child: const Text('AAN'),
                      ),
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          requestURLIndex = 1;
                          buttonPressed();
                        },
                        child: const Text('UIT'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
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
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          requestURLIndex = 2;
                          buttonPressed();
                        },
                        child: const Text('TRAAG'),
                      ),
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
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
            Card(
              color: Colors.white,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
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
                    alignment: MainAxisAlignment.start,
                    children: [
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          requestURLIndex = 4;
                          buttonPressed();
                        },
                        child: const Text('OMHOOG'),
                      ),
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
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
            Container(
              child: FloatingActionButton.extended(
                //alignment: MainAxisAlignment.end,
                backgroundColor: Color(0xFF6200EE),
                foregroundColor: Colors.white,
                onPressed: () {
                  //Respond to button press
                },
                icon: Icon(Icons.add),
                label: Text('RESET'),
              ),
            ),
          ],
        ),
      ),
    );
  }

// import "package:flutter/material.dart";

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> {
//   var buttonIndex = 0;

//   void buttonPressed() {
//     setState(() {
//       buttonIndex++;
//     });
//     print(buttonIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text("StarTracker"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Align(
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(
//                   10,
//                   10,
//                   0,
//                   0,
//                 ),
//                 child: Text(
//                   'Status:',
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 alignment: Alignment.topLeft,
//               ),
//             ),
//             ButtonBar(
//               alignment: MainAxisAlignment.spaceEvenly,
//               buttonHeight: 100.0,
//               buttonMinWidth: 150.0,
//               children: [
//                 RaisedButton(
//                   child: Text(
//                     'Aan',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//                 RaisedButton(
//                   child: Text(
//                     'Uit',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//               ],
//             ),
//             Align(
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(
//                   10,
//                   30,
//                   0,
//                   0,
//                 ),
//                 child: Text(
//                   'Snelheid:',
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 alignment: Alignment.topLeft,
//               ),
//             ),
//             ButtonBar(
//               alignment: MainAxisAlignment.spaceEvenly,
//               buttonHeight: 100.0,
//               buttonMinWidth: 150.0,
//               children: [
//                 RaisedButton(
//                   child: Text(
//                     'Traag',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//                 RaisedButton(
//                   child: Text(
//                     'Snel',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//               ],
//             ),
//             Align(
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(
//                   10,
//                   30,
//                   0,
//                   0,
//                 ),
//                 child: Text(
//                   'Richting:',
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 alignment: Alignment.topLeft,
//               ),
//             ),
//             ButtonBar(
//               alignment: MainAxisAlignment.spaceEvenly,
//               buttonHeight: 100.0,
//               buttonMinWidth: 150.0,
//               children: [
//                 RaisedButton(
//                   child: Text(
//                     'Omhoog',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//                 RaisedButton(
//                   child: Text(
//                     'Omlaag',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   onPressed: buttonPressed,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}

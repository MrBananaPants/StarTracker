import "package:flutter/material.dart";

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
  var buttonIndex = 0;

  void buttonPressed() {
    setState(() {
      buttonIndex++;
    });
    print(buttonIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 98, 0, 238),
          title: Text("StarTracker"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Status'),
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
                          //Perform some action
                        },
                        child: const Text('AAN'),
                      ),
                      FlatButton(
                        textColor: const Color(0xFF6200EE),
                        onPressed: () {
                          //Perform some action
                        },
                        child: const Text('UIT'),
                      ),
                    ],
                  ),
                ],
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

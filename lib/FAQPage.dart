import "package:flutter/material.dart";

class FAQPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("FAQ"),
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
                      'Hoe werkt de app',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "De app stuurt commando's naar een ESP8266 die draadloos via WiFi met dit apparaat verbonden is. De ESP8266 leest deze commando's dan en voert ze uit.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      // style: TextStyle(
                      //   fontSize: 16.0,
                      // ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 13, right: 13, top: 3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Hoe is de app gemaakt',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "De app is volledig in Dart (Flutter) geschreven in de Visual Studio Code IDE. De app is open-source en staat op GitHub (de GitHub repository staat in de 'Over' pagina).",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      // style: TextStyle(
                      //   fontSize: 16.0,
                      // ),
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.only(left: 13, right: 13, top: 3),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Waar kan ik feedback geven',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(
                      "Alle feedback kan gestuurd worden naar joran.vancoillie@gmail.com. Bugs kunnen in de GitHub pagina gerapporteerd worden.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      // style: TextStyle(
                      //   fontSize: 16.0,
                      // ),
                    ),
                  ),
                ],
              ),
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
          //             'Over deze app',
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          //           child: Text(
          //             "Deze app is door Joran ontwikkeld voor zijn GIP StarTracker. Met deze app kan de StarTracker draadloos bediend worden.",
          //             style: TextStyle(
          //               color: Colors.black.withOpacity(0.6),
          //             ),
          //             // style: TextStyle(
          //             //   fontSize: 16.0,
          //             // ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
        ],
      ),
    );
  }
}

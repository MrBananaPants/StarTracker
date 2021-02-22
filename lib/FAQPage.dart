import "package:flutter/material.dart";

class FAQPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyOfFAQPageState();
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //Light theme data
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          headline3: TextStyle(),
        ).apply(bodyColor: Colors.blue),
        scaffoldBackgroundColor: Color(0xFFf3f3f8),
        cardColor: Colors.white,
        shadowColor: Color(0xFFe2f1fd),
        iconTheme: IconThemeData(color: Colors.black),
        appBarTheme: AppBarTheme(color: Color(0xFFf3f3f8)),
        bottomAppBarColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF3D5AFE),
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE)),
      ),
      darkTheme: ThemeData(
        //Dark theme data
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          headline3: TextStyle(),
        ).apply(bodyColor: Colors.white),
        scaffoldBackgroundColor: Color(0xFF2b2b2b),
        backgroundColor: Colors.black,
        cardColor: Color(0xFF454545),
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(color: Color(0xFF2b2b2b)),
        bottomAppBarColor: Color(0xFF454545),
        buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF3D5AFE),
            shape: RoundedRectangleBorder(),
            textTheme: ButtonTextTheme.primary),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE)),
      ),
      home: BodyOfFAQPage(),
    ),
  );
}

class BodyOfFAQPage extends StatefulWidget {
  @override
  BodyOfFAQPageState createState() => BodyOfFAQPageState();
}

class BodyOfFAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              pinned: false,
              expandedHeight: 50.0,
              //backgroundColor: Color(0xFFf3f3f8),
              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                title: Text(
                  'FAQ',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontFamily: 'SF',
                  ),
                ),
                centerTitle: false,
                // collapseMode: ,
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
                              'Hoe werkt de app',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: 'SF',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "De app stuurt commando's naar een ESP8266 die draadloos via WiFi met dit apparaat verbonden is. De ESP8266 leest deze commando's dan en voert ze uit.",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
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
                              'Hoe is de app gemaakt',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "De app is volledig in Dart (Flutter) geschreven in de Visual Studio Code IDE. De app is open-source en staat op GitHub (de GitHub repository staat in de 'Over' pagina).",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
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
                              'Waar kan ik feedback geven',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "Feedback en bugs kunnen in de GitHub pagina gerapporteerd worden.",
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
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
            ),
          ],
        ),
      ),
    );
  }
}

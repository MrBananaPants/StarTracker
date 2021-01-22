import 'package:flutter/material.dart';
import 'package:condition/condition.dart';
import 'package:flutter_course_1/processing/class_initial.dart';
import 'package:flutter/services.dart';

class home_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return home_screenState();
  }
}

class home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent
    ));
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
              "image/background.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color(0xFF3D5AFE),
            label: Text("Reset"),
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Color(0xFF3D5AFE),
                  ),
                ),
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    //Nothing yet...
                  },
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                    //Nothing yet...
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            elevation: 4,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text("StarTracker", style: TextStyle(fontFamily: "Equinox", fontWeight: FontWeight.bold),),
            toolbarHeight: 70,
          ),
          body: Container(
            margin: EdgeInsets.only(left: 13, right: 13, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Status',
                          ),
                        ),
                        ButtonBar(
                          buttonHeight: 40,
                          buttonMinWidth: 150,
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
                              onPressed: () {
                                requestURLIndex = 0;
                                buttonPressed();
                              },
                              child: Text('AAN'),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
                              onPressed: () {
                                requestURLIndex = 1;
                                buttonPressed();
                              },
                              child: Text('UIT'),
                            ),
                          ],
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
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                          buttonHeight: 40,
                          buttonMinWidth: 150,
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
                              onPressed: () {
                                requestURLIndex = 2;
                                buttonPressed();
                              },
                              child: const Text('TRAAG'),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
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
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                          buttonHeight: 40,
                          buttonMinWidth: 150,
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
                              onPressed: () {
                                requestURLIndex = 4;
                                buttonPressed();
                              },
                              child: const Text('OMHOOG'),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: Color(0xFF3D5AFE),
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
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Title',
                          ),
                        ),
                        Row(
                          children: [
                            Text("Simulate State : "),
                            Switch(
                                value: buttonGotPressed,
                                onChanged: (bool value_changed){
                                  setState(() {
                                    buttonGotPressed = value_changed;
                                    print("Button State = $buttonGotPressed");
                                  });
                                }
                            )
                          ],
                        ),
                        Container(
                            child:
                            Conditioned(
                                cases:
                                [
                                  Case(buttonGotPressed == true, builder: () => ButtonBar(
                                    buttonHeight: 40,
                                    buttonMinWidth: 150,
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      OutlineButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        onPressed: () {
                                        },
                                        child: const Text('On'),
                                      ),
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        color: Color(0xFF3D5AFE),
                                        onPressed: () {
                                        },
                                        child: const Text('Off'),
                                      ),
                                    ],
                                  )),
                                  Case(buttonGotPressed == false, builder: () => ButtonBar(
                                    buttonHeight: 40,
                                    buttonMinWidth: 150,
                                    alignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        color: Color(0xFF3D5AFE),
                                        onPressed: () {
                                        },
                                        child: const Text('On'),
                                      ),
                                      OutlineButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)),
                                        onPressed: () {
                                        },
                                        child: const Text('Off'),
                                      ),
                                    ],
                                  )),
                                ],
                                defaultBuilder: () =>Text("Null value returned"))
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

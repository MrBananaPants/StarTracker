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
  @override void initState() {
    remove_Navigation_color();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 30),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Color(0xFF3D5AFE),
              label: Text("Reset"),
              icon: Icon(Icons.refresh),
              onPressed: () {},
            ),
            backgroundColor: Colors.transparent,
            drawer: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Drawer(
                elevation: 100,
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
            ),
            appBar: AppBar(
              elevation: 4,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text("StarTracker", style: TextStyle(fontFamily: "Equinox", fontWeight: FontWeight.bold, letterSpacing: 1.6, fontSize: 23),),
              toolbarHeight: 70,
            ),
            body: Container(
              margin: EdgeInsets.only(left: 13, right: 13, top: 20),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Status',
                              style: TextStyle(
                                  fontFamily: "Equinox",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.orangeAccent,
                                letterSpacing: 1
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            children: [
                              Text("Conntection : ", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),),
                              Container(
                                  child:
                                  Conditioned(
                                      cases:
                                      [
                                        Case(connection == true, builder: () => Text("Established", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2))),
                                        Case(connection == false, builder: () => Text("Lost Connection", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2))),
                                      ],
                                      defaultBuilder: () =>Text("Unknow State", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)))
                              ),

                            ],
                          ),
                          SizedBox(height: 30,),
                          Container(
                              child:
                              Conditioned(
                                  cases:
                                  [
                                    Case(connection == true, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('ON'),
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            requestURLIndex = 0;
                                            buttonPressed();
                                            setState(() {
                                              connection = false;
                                            });
                                          },
                                          child: Text('OFF'),
                                        ),
                                      ],
                                    ),),
                                    Case(connection == false, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            requestURLIndex = 0;
                                            buttonPressed();
                                            setState(() {
                                              connection = true;
                                            });
                                          },
                                          child: Text('ON'),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('OFF'),
                                        ),
                                      ],
                                    ),),
                                  ],
                                  defaultBuilder: () =>Text("Unknow State", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)))
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Speed',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: "Equinox",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.orangeAccent
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                              child:
                              Conditioned(
                                  cases:
                                  [
                                    Case(speed_fast == true, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('Fast'),
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            requestURLIndex = 0;
                                            buttonPressed();
                                            setState(() {
                                              speed_fast = false;
                                            });
                                          },
                                          child: Text('Slow'),
                                        ),
                                      ],
                                    ),),
                                    Case(speed_fast == false, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            if(connection == true)
                                              {
                                                requestURLIndex = 0;
                                                buttonPressed();
                                                setState(() {
                                                  speed_fast = true;
                                                });
                                              }
                                          },
                                          child: Text('Fast'),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('Slow'),
                                        ),
                                      ],
                                    ),),
                                  ],
                                  defaultBuilder: () =>Text("Unknow State", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)))
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Direction',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: "Equinox",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.orangeAccent
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
                              child:
                              Conditioned(
                                  cases:
                                  [
                                    Case(direction_up == true, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('Up'),
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            requestURLIndex = 0;
                                            buttonPressed();
                                            setState(() {
                                              direction_up = false;
                                            });
                                          },
                                          child: Text('Down'),
                                        ),
                                      ],
                                    ),),
                                    Case(direction_up == false, builder: () => ButtonBar(
                                      buttonPadding: EdgeInsets.all(0),
                                      buttonHeight: 40,
                                      buttonMinWidth: 150,
                                      alignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15)),
                                          color: Colors.orange,
                                          onPressed: () {
                                            if(connection == true)
                                              {
                                                requestURLIndex = 0;
                                                buttonPressed();
                                                setState(() {
                                                  direction_up = true;
                                                });
                                              }
                                          },
                                          child: Text('Up'),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(color: Colors.orangeAccent)
                                          ),
                                          textColor: Colors.orangeAccent,
                                          color: Colors.transparent,
                                          onPressed: () {
                                            requestURLIndex = 1;
                                            buttonPressed();
                                          },
                                          child: Text('Down'),
                                        ),
                                      ],
                                    ),),
                                  ],
                                  defaultBuilder: () =>Text("Unknow State", style: TextStyle(fontFamily: "Equinox", color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)))
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    color: Colors.grey.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Testing Area',
                              style: TextStyle(
                                  fontFamily: "Equinox",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.orangeAccent
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text("Simulate Connection : ", style: TextStyle(color: Colors.white),),
                              Switch(
                                  value: connection,
                                  onChanged: (bool value_changed){
                                    setState(() {
                                      connection = value_changed;
                                      if(connection == false)
                                        {
                                          speed_fast = false;
                                          direction_up = false;
                                        }
                                    });
                                  }
                              ),
                              Text("$connection", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          Row(
                            children: [
                              Text("Simulate Speed : ", style: TextStyle(color: Colors.white),),
                              Switch(
                                  value: speed_fast,
                                  onChanged: (bool value_changed){
                                    setState(() {
                                      speed_fast = value_changed;
                                    });
                                  }
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("Simulate Direction : ", style: TextStyle(color: Colors.white),),
                              Switch(
                                  value: direction_up,
                                  onChanged: (bool value_changed){
                                    setState(() {
                                      direction_up = value_changed;
                                    });
                                  }
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

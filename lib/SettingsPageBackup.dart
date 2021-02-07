import 'package:condition/condition.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }
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

void changeThemeToAAN() => buttonThema = true;
void changeThemeToUIT() => buttonThema = false;

bool buttonThema = false;

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Color(0xFF0031CA),
        title: Text("Instellingen"),
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
                      'Thema',
                    ),
                  ),
                  Container(
                      child: Conditioned(cases: [
                    Case(
                      buttonThema == true,
                      builder: () => ButtonBar(
                        buttonHeight: 40,
                        buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text('AAN'),
                            onPressed: () {
                              setState(
                                () {
                                  changeThemeToUIT();
                                },
                              );
                            },
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: Color(0xFF3D5AFE),
                            child: const Text('UIT'),
                            onPressed: () {
                              setState(
                                () {
                                  changeThemeToAAN();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Case(buttonThema == false,
                        builder: () => ButtonBar(
                              buttonHeight: SizeConfig.blockSizeVertical * 5.5,
                              buttonMinWidth:
                                  SizeConfig.blockSizeHorizontal * 36,
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  color: Color(0xFF3D5AFE),
                                  child: const Text('AAN'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeThemeToUIT();
                                      },
                                    );
                                  },
                                ),
                                OutlineButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text('UIT'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        changeThemeToAAN();
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                  ], defaultBuilder: () => Text("Null value returned"))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

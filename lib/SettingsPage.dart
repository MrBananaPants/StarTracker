import 'package:condition/condition.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart';

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

bool buttonLED = false;

void changeLEDToAAN() => buttonLED = false;
void changeLEDToUIT() => buttonLED = true;

var requestURLIndex = 0;
var requestURL = [
  'http://192.168.4.1/LedAan',
  'http://192.168.4.1/LedUit',
];

void buttonPressed() {
  String url = requestURL[requestURLIndex];
  get(url);
}

class SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Instellingen',
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
                              'Arduino LED',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Container(
                            child: Conditioned(
                              cases: [
                                Case(
                                  buttonLED == true,
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
                                            setState(() {
                                              changeLEDToAAN();
                                              requestURLIndex = 0;
                                              buttonPressed();
                                            });
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(minimumSize: Size(SizeConfig.blockSizeHorizontal * 38, 40)),
                                          child: const Text('UIT'),
                                          onPressed: () {
                                            setState(() {
                                              changeLEDToUIT();
                                              requestURLIndex = 1;
                                              buttonPressed();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Case(
                                  buttonLED == false,
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
                                                changeLEDToAAN();
                                                requestURLIndex = 0;
                                                buttonPressed();
                                              },
                                            );
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
                                                changeLEDToUIT();
                                                requestURLIndex = 1;
                                                buttonPressed();
                                              },
                                            );
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

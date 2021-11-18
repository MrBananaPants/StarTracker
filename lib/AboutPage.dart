import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<AboutPage> {
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
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Over',
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
                              'Over deze app',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                            child: Text(
                              "Deze app is door Joran ontwikkeld voor zijn GIP StarTracker. Met deze app kan de StarTracker draadloos bediend worden.",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'GitHub',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 18),
                            child: GestureDetector(
                              child: Text(
                                "GitHub StarTracker",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                              onTap: () {
                                launch("https://github.com/MrBananaPants/StarTracker");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Versie: v1.4.0-stable",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          "Flutter: 2.5.3",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          "Joran Vancoillie",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                        ),
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
}

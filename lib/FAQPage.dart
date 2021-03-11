import "package:flutter/material.dart";

class FAQPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyOfFAQPageState();
  }
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
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'FAQ',
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
                                color: Theme.of(context).textTheme.bodyText1.color,
                                fontFamily: 'SF',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "De app stuurt commando's naar een ESP8266 die draadloos via WiFi met dit apparaat verbonden is. De ESP8266 leest deze commando's dan en voert ze uit.",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
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
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "De app is volledig in Dart (Flutter) geschreven in de Visual Studio Code IDE. De app is open-source en staat op GitHub (de GitHub repository staat in de 'Over' pagina).",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
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
                                color: Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "Feedback en bugs kunnen in de GitHub pagina gerapporteerd worden.",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyText1.color,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

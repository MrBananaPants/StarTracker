import 'package:flutter/material.dart';

ThemeData lightTheme = buildLightTheme();
ThemeData darkTheme = buildDarkTheme();

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme:
          TextTheme(bodyText2: TextStyle(color: Color(0xFF3D5AFE)), bodyText1: TextStyle(color: Colors.black), headline3: TextStyle(color: Colors.black)),
      scaffoldBackgroundColor: Color(0xFFf6f6fb),
      canvasColor: Color(0xFFfbfafa),
      cardColor: Colors.white,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 11.5,
        clipBehavior: Clip.antiAlias,
      ),
      shadowColor: Color(0xFFedf6ff),
      iconTheme: IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(color: Color(0xFFf6f6fb)),
      bottomAppBarColor: Colors.white,
      bottomAppBarTheme: BottomAppBarTheme(elevation: 11.5),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: Color(0xFF3D5AFE), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: OutlinedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF3D5AFE),
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE)));
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    //Dark theme data
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white), bodyText1: TextStyle(color: Colors.white), headline3: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: Color(0xFF2b2b2b),
    canvasColor: Color(0xFF454545),

    backgroundColor: Colors.black,
    cardColor: Color(0xFF454545),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 15,
      clipBehavior: Clip.antiAlias,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(color: Color(0xFF2b2b2b)),
    bottomAppBarColor: Color(0xFF454545),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: Color(0xFF3D5AFE), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
    outlinedButtonTheme:
        OutlinedButtonThemeData(style: ElevatedButton.styleFrom(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))))),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xFF3D5AFE), shape: RoundedRectangleBorder(), textTheme: ButtonTextTheme.primary),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Color(0xFF3D5AFE)),
  );
}

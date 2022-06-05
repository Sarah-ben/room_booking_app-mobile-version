import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor:Colors.black,
    primarySwatch: Colors.blue,
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent,

    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        backgroundColor:Colors.black ,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        elevation: 20.0

    ),
    appBarTheme:const AppBarTheme(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),

        //didn't work
        textTheme: TextTheme(
            bodyText1: TextStyle(
                color: Colors.white
            )
        ),

        backgroundColor: Colors.black,
        elevation: 0.0
    )
);
ThemeData lightTheme= ThemeData(
    floatingActionButtonTheme:const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent
    ),
    bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        elevation: 20.0
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:const AppBarTheme(
        titleSpacing: 20.0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        color: Colors.white,
        elevation: 0.0
    )
);
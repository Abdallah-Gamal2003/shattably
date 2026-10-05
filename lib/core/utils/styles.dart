import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch:  Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,

    ),
    iconTheme: IconThemeData(
      color: Colors.black,

    ),
  ) ,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:Colors.blue,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color:Colors.black,
    ),
  ),
  // fontFamily: 'Jannah',

);

const kTitleStyle = TextStyle(
fontSize: 20.0,
fontWeight: FontWeight.bold,
);

final kDecoration = BoxDecoration(
  borderRadius:  BorderRadius.circular(10.0,),
  color: Colors.white,
);

const String kBaseImage = 'assets/images/';

const kTextDialog =  TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
);

const kTextOrder =  TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kTextDialogBody = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
);

const kTextDialogRightBody = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
);

const kStyleAppBar = TextStyle(
  color: Colors.black,
  fontSize: 22.0,
  fontWeight: FontWeight.w400,
);


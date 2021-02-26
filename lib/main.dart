import 'package:flutter/material.dart';
import 'package:mhencicopledia/pages/home_page.dart';
import 'package:mhencicopledia/pages/monster_page.dart';

import 'helpers/stroke.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/' :(BuildContext context)=>HomePage(),
        'monster':(BuildContext context)=>MonsterPage()
      },
      theme: ThemeData(        
        fontFamily: 'Medieval',
        tabBarTheme: TabBarTheme(
          labelPadding: EdgeInsets.all(0),
          indicator: ShapeDecoration(
            shape: Border(bottom: BorderSide(color:Color(0xFFb38455),width: 2 )),
          )
        ),
        primaryColor:Color(0xFFb38455),
        secondaryHeaderColor: Color(0xFFd4a272),
        textTheme: TextTheme(
        //principalmente se usa en la descripcion de los monstruos
          bodyText1: TextStyle(
              color:Colors.black,
              fontWeight:FontWeight.bold,
              fontSize: 16,
          ),
        headline1: TextStyle(
          color:Colors.yellow, 
          fontWeight:FontWeight.bold,
          fontSize: 18,
          shadows: outlinedText()
          ),
        bodyText2: TextStyle(
            color: Colors.black, 
            fontWeight:FontWeight.bold,
            fontSize: 12, 
          )  
        )  
      ),
    );
  }
}
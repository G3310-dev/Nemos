import 'package:flutter/material.dart';
import 'package:nemos/Page/undead.dart';


class Routing {
  static Route<dynamic> generateRoute(RouteSettings Route){
    switch (Route.name){
      // case "/" :
      //   return MaterialPageRoute(builder: (_) => Home());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}
import 'package:flutter/material.dart';
import 'package:nemos/Page/Authentication/sign_in.dart';
import 'package:nemos/Page/Authentication/sign_up.dart';
import 'package:nemos/Page/add_case.dart';
import 'package:nemos/Page/get_started.dart';
import 'package:nemos/Page/home.dart';
import 'package:nemos/Page/undead.dart';


class Routing {
  static Route<dynamic> generateRoute(RouteSettings Route){

    switch (Route.name){
      case "/" :
        return MaterialPageRoute(builder: (_) => const Home());
      case "/addCase" :
        return MaterialPageRoute(builder: (_) => const AddCase());
      case "/getStart":
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case "/signIn":
        return MaterialPageRoute(builder: (_) => const SignIn());
      case "/signUp":
        return MaterialPageRoute(builder: (_) => const SignUp());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}
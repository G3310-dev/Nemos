import 'package:flutter/material.dart';
import 'package:nemos/Page/Authentication/sign_in.dart';
import 'package:nemos/Page/Authentication/sign_up.dart';
import 'package:nemos/Page/add_case.dart';
import 'package:nemos/Page/add_certificate.dart';
import 'package:nemos/Page/add_username.dart';
import 'package:nemos/Page/get_started.dart';
import 'package:nemos/Page/home.dart';
import 'package:nemos/Page/settings.dart';
import 'package:nemos/Page/undead.dart';

import '../Page/literasi_hukum.dart';


class Routing {
  static Route<dynamic> generateRoute(RouteSettings Route){

    switch (Route.name){
      case "/" :
        return MaterialPageRoute(builder: (_) => Home());
      case "/addCase" :
        return MaterialPageRoute(builder: (_) => const AddCase());
      case "/getStart":
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case "/signIn":
        return MaterialPageRoute(builder: (_) => const SignIn());
      case "/signUp":
        return MaterialPageRoute(builder: (_) => const SignUp());
      case "/setting":
        return MaterialPageRoute(builder: (_) => Settings());
      case "/addUser":
        return MaterialPageRoute(builder: (_) => const AddUsername());
      case "/addCerti":
        return MaterialPageRoute(builder: (_) => const AddCertificate());
      case "/literaKum":
        return MaterialPageRoute(builder: (_) => LiteraKum());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nemos/Page/get_started.dart';
import 'package:nemos/Page/home.dart';
import 'package:nemos/Wrapper/auth_wrapper.dart';
import 'package:provider/provider.dart';

import 'Wrapper/route_wrapper.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthWrap>(
          create: (_) => AuthWrap(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthWrap>().authStateChanges, initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Nemos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        ),
        onGenerateRoute: Routing.generateRoute,
        // initialRoute: "/",
        home: const AuthenticationWrapper(),
      ),
    );
  }
}


class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Home();
    } else {
      return const GetStarted();
    }
  }
}
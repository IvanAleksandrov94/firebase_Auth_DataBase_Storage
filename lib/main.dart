import 'package:firestore/screens/landing.dart';
import 'package:firestore/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: "MyAppFirebase",
        home: LandingPage(),
      ),
    );
  }
}

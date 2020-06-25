import 'file:///G:/esunb/Github/catbook/cat_posting_app/lib/services/JoinOrLogin.dart';
import 'file:///G:/esunb/Github/catbook/cat_posting_app/lib/screens/timeline.dart';
import 'file:///G:/esunb/Github/catbook/cat_posting_app/lib/screens/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      theme: NeumorphicThemeData(
//        baseColor: Color(0xFFffffff),
        baseColor: Color(0xfff4f5f9),
//        baseColor: Colors.blueGrey[100],
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home: Scaffold(
        body: Splash(),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance
            .onAuthStateChanged, // Whenever it's sign in or sign out or sign up
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            //  If it's not login (When it's log out )
            return ChangeNotifierProvider<JoinOrLogin>(
              create: (context) => JoinOrLogin(),
              child: LoginPage(), // Go to Loginpage
            );
          } else {
            // otherwise call Timeline widget
            return Timeline(email: snapshot.data.email);
          }
        });
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});
  final String email ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(email),
      ),
      body: Container(
        child: Center(
          child: FlatButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          }
          , child: Text("Logout")),
        ),
      ),
    );
  }
}

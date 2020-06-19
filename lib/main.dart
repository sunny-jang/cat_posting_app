import 'package:catpostingapp/JoinOrLogin.dart';
import 'package:catpostingapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final AuthService _auth =  AuthService();
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFffffff),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      home:Scaffold(
        body: ChangeNotifierProvider<JoinOrLogin>(
          create: (context) => JoinOrLogin(),
          child: Consumer<JoinOrLogin>(
            builder: (context, value, child) => Container(
              color: value.isJoin ? Colors.blueGrey[100] : Colors.grey[100] ,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/login_cat.gif"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    (value.isJoin ? "Welcome to Catbook!" : "Sign up now!" ),
                    style: TextStyle(fontSize: 40, fontFamily: 'Amatic', fontWeight: FontWeight.w700, color: Colors.grey[800],),
                  ),

                  Neumorphic(
                    margin: EdgeInsets.all(30),
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Form(
                          child: Column(
                            children: <Widget>[
                              Neumorphic(
                                padding: EdgeInsets.only(left: 15),
                                style: NeumorphicStyle(
                                  depth: -2,
                                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "catstagram.google.com",
                                      icon: Icon(Icons.account_circle),
                                    enabledBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Neumorphic(
                                padding: EdgeInsets.only(left: 15),
                                style: NeumorphicStyle(
                                    depth: -2,
                                    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: "password",
                                      enabledBorder: InputBorder.none,
                                      icon: Icon(Icons.security),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    child: Text(value.isJoin ? "Sign in" : "Sign up", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: () async{
                      dynamic result = await _auth.signInAnon();
                    },
                  ),
                  GestureDetector(
                    child: Text('Dont have an Account? Create One', style: TextStyle(fontWeight: FontWeight.bold),),
                    onTap: () {
                     value.toggle();
                    },

                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


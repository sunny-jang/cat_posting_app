import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      home:Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),

              Text(
                  "Welcom to Catstagram!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 70,
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
                              depth: -5,
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                            ),
                            child: TextFormField(
                              obscureText: true,
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
                margin: EdgeInsets.only(top: 20, bottom: 50),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Text("Sign in", style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: (){},
              ),
              GestureDetector(
                child: Text('Dont have an Account? Create One', style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: () {
                  print('yo');
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}


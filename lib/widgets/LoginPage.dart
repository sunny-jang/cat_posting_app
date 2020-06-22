import 'package:catpostingapp/JoinOrLogin.dart';
import 'package:catpostingapp/timeline.dart';
import 'package:catpostingapp/widgets/ForgetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<JoinOrLogin>(
      builder: (context, value, child) => Container(
        color: value.isJoin ? Colors.blueGrey[100] : Colors.grey[100],
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            SvgPicture.asset(
              'assets/logo.svg',
              width: 200,
              color: Color(0xff549FDD),
            ),
            Container(
              height: 200,
              child: FittedBox(
                fit: BoxFit.cover,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/login_cat.gif"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (value.isJoin ? "Welcome to Catbook!" : "Sign up now!"),
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Amatic',
                fontWeight: FontWeight.w700,
                color: Colors.grey[800],
              ),
            ),
            Neumorphic(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Neumorphic(
                        padding: EdgeInsets.only(left: 15),
                        style: NeumorphicStyle(
                            depth: -2,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20))),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "catstagram.google.com",
                            icon: Icon(Icons.account_circle),
                            enabledBorder: InputBorder.none,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please input correct Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Neumorphic(
                        padding: EdgeInsets.only(left: 15),
                        style: NeumorphicStyle(
                            depth: -2,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20))),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "password",
                            enabledBorder: InputBorder.none,
                            icon: Icon(Icons.security),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please  input correct Password";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            NeumorphicButton(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                value.isJoin ? "Sign in" : "Sign up",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  value.isJoin ? _login(context) : _register(context);
                  print(_emailController.text.toString());
                  print(_passwordController.text.toString());
                }
                ;
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                child: Text(
                  value.isJoin ? 'Forgot password?' : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPassword()));
                },
              ),
            ),
            GestureDetector(
              child: Text(
                value.isJoin
                    ? 'Dont have an account?'
                    : 'Do you already have an accout?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
    );
  }

  void _register(BuildContext context) async {
    print("register!!!");
    final AuthResult result =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //  Create a new user with giving email and password
      email: _emailController.text,
      // we need to set a controller with TextFormField widget
      password: _passwordController
          .text, // we need to set a controller with TextFormField widget
    );
    print(result.user);
    // send _emailController and _passwordController's text to Firebase and make an instance

    final FirebaseUser user =
        result.user; // after making a new user, save it as user

    if (user == null) {
      // if it didn't work, fulfil this code
      print('fail $user');
      final snackbar = SnackBar(
          content: Text("Please try again lager.")); // Making a snackbar
      Scaffold.of(context).showSnackBar(snackbar);
    }

    print(user);

    Navigator.push(
        context,
        MaterialPageRoute(
            // Move to another page
            builder: (context) => Timeline(email: user.email)));
  }

  void _login(BuildContext context) async {
    // Almost same code with _register()
    print("login!!!");
    final AuthResult result =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      // Request Sign in with the giving email and password
      email: _emailController.text,
      password: _passwordController.text,
    );
    // send _emailController and _passwordController's text to Firebase and make an instance

    final FirebaseUser user = result.user;

    if (user == null) {
      final snackbar = SnackBar(content: Text("Please try again lager."));
      Scaffold.of(context).showSnackBar(snackbar);
    }

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Timeline(email: user.email)));
  }
}

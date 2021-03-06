import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  //Because we will use form
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailControllor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget password", style: TextStyle(color: Colors.grey[600]),),
        backgroundColor: Colors.black,

      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailControllor,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: "Email",
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Please input correct Email";
                  }
                  return null;
                },
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: FlatButton(
                  color: Colors.grey,
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailControllor.text);

                    final snackBar = SnackBar(
                      content: Text("Check your email for pw reset"),
                    );

                    Scaffold.of(_formKey.currentContext).showSnackBar(snackBar);
                  },
                  child: Text("Reset Password"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

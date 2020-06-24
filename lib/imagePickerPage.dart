
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ImagePickerPage extends StatefulWidget {

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  var file = 'assets/placeholder-client.png';
  var des = 'test';

  final dbRef = FirebaseDatabase.instance.reference().child("posts");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        actions: [
          NeumorphicButton(
            child: Text('done'),
            onPressed: (){
              print(file);
              dbRef.push().set({
                "image_url" : file,
                "description" : des,
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              child: Image(
                height: 200,
                image: AssetImage('assets/placeholder-client.png'),
                color: Colors.grey[500],
              ),
            ),
            Container(
              color: Colors.grey[300],
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              child: Form(
                child: TextFormField(
                  maxLines: 5,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "description"
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NeumorphicButton(
                  child: Text("Open Camera", style: TextStyle(fontWeight: FontWeight.bold),),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  onPressed: () {
                  },
                  style: NeumorphicStyle(
                    depth: 9,
                    shape: NeumorphicShape.concave
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                NeumorphicButton(
                  child: Text("Open Gallery", style: TextStyle(fontWeight: FontWeight.bold),),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  onPressed: () {

                  },
                  style: NeumorphicStyle(
                      depth: 9,
                      shape: NeumorphicShape.concave
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

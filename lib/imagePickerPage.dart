import 'dart:io';

import 'package:catpostingapp/timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("posts/cat_list");
  var userInfo;
  final _picker = ImagePicker();

  File _image;

  void openCamera() async {
    var selectedImage = await _picker.getImage(source: ImageSource.camera);
    final File file = File(selectedImage.path);

    setState(() {
      _image = file;
    });
  }

  void openGallery() async {
    var selectedImage = await _picker.getImage(source: ImageSource.gallery);
    final File file = File(selectedImage.path);

    setState(() {
      _image = file;
    });
  }

  void getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      userInfo = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        actions: [
          NeumorphicButton(
            padding: EdgeInsets.all(12),
            child: Text("done"),
            onPressed: () async {
              await getUserInfo();

              dbRef.push().set({
                "userId": userInfo.uid,
                "userEmail": userInfo.email,
                "image": _image,
                "des": _descriptionController.text,
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Timeline(),
                  ));
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              child: _image == null
                  ? Image(
                      height: 200,
                      image: AssetImage('assets/placeholder-client.png'),
                      color: Colors.grey[500],
                    )
                  : Image.file(
                      _image,
                      height: 200,
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
                  decoration: InputDecoration(hintText: "Description"),
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
                  child: Text(
                    "Open Camera",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  onPressed: () {
                    openCamera();
                  },
                  style:
                      NeumorphicStyle(depth: 9, shape: NeumorphicShape.concave),
                ),
                SizedBox(
                  width: 20,
                ),
                NeumorphicButton(
                  child: Text(
                    "Open Gallery",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  onPressed: () {
                    openGallery();
                  },
                  style:
                      NeumorphicStyle(depth: 9, shape: NeumorphicShape.concave),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

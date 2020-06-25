import 'dart:io';

import 'package:catpostingapp/timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child("posts/cat_list");
  final stRef = FirebaseStorage.instance.ref();

  var userInfo;
  final _picker = ImagePicker();
  var _uploadedFileURL;
  File _image;
  var imageByte;

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

    print("image = $_image");
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
              StorageUploadTask uploadTask = stRef
                  .child("cats/${path.basename(_image.path)}")
                  .putFile(_image);

              var dowurl =
                  await (await uploadTask.onComplete).ref.getDownloadURL();
              setState(() {
                _uploadedFileURL = dowurl.toString();
              });


              if (_image != null && userInfo != null) {
                dbRef.push().set({
                  "uploadTime" : new DateTime.now().toString(),
                  "userId": userInfo.uid,
                  "userEmail": userInfo.email,
                  "image": _uploadedFileURL,
                  "des": _descriptionController.text,
                });

                _descriptionController.clear();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Timeline(),
                    ));
              } else {
                final snackbar =
                    SnackBar(content: Text("Please Pick an image."));
                Scaffold.of(_formKey.currentContext).showSnackBar(snackbar);
              }
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

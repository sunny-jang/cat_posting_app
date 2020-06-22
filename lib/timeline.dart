import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});

  final String email;

  List<Widget> makeImagesList() {
    List<Widget> imageItems = [];
    for (int i = 1; i <= 3; i++) {
      imageItems.add(ImageGridItem(i));
    }
    return imageItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          "CatBook",
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Amatic',
              letterSpacing: 5),
        ),
        actions: <Widget>[
          NeumorphicButton(
            child: Icon(Icons.account_circle),
            style: NeumorphicStyle(
              depth: 3,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Column(
                children: makeImagesList(),
              ),
            ),
            NeumorphicButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                "Add image",
                style: TextStyle(
                  fontFamily: 'Amatic',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              onPressed: () {},
            ),

            NeumorphicButton(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                "Sign out",
                style: TextStyle(
                  fontFamily: 'Amatic',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  int _index; // Get index when it's made by its class.

  ImageGridItem(int index) {
    this._index = index; // we need it
  }

  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile; // Same as var imageFile

  StorageReference photoReference =
      FirebaseStorage.instance.ref().child("Kukdong");

  // FirebaseStorage.intance 생성 and ref its child "Kukdong"
  getImage() {
    int MAX_SIZE = 7 * 1024 * 1024; // we need Maxsize when we call "getData"
    photoReference
        .child("kukdong${widget._index}.jpg")
        .getData(MAX_SIZE)
        .then((data) { // after getting the data
      this.setState(() {
        imageFile = data;
      });
    }).catchError((error) {});
  }

  Widget decideGridTileWidget() {
    if (imageFile == null) {
      // if there is no image file in each Image item
      return Center(child: Text("No Data"));
    } else {
      // if we got a image data
      return Image.memory(imageFile, fit: BoxFit.cover);
    }
  }

  @override
  void initState() { //  this code calls getImage function.
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget());
  }
}

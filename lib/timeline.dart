import 'dart:typed_data';

import 'package:catpostingapp/imagePickerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});

  final String email;

  List<Widget> makeImagesList() {
    List<Widget> imageItems = [
      postItem(),
      postItem(),
      postItem(),
      postItem(),
      postItem(),
    ];

    return imageItems;
  }

  Widget postItem() {
    return Neumorphic(
      margin: EdgeInsets.only(top: 30),
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        depth: 50,
        lightSource: LightSource.topLeft,
        color: Color(0xffe9eff5),
      ),
      child: Container(
//        color: Colors.red[200],
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Neumorphic(
              margin: EdgeInsets.only(bottom: 20),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              ),
              child: ImageGridItem(1),
            ),
            Text(
              "My cuteass cat for this Catbook app  #극동이",
              style: TextStyle(
                fontFamily: 'Amatic',
                fontWeight: FontWeight.w900,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: NeumorphicButton(
          child: Icon(Icons.camera_alt),
          style: NeumorphicStyle(
            depth: 5,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          ),
          onPressed: () {},
        ),
        title: Center(
          child: Text(
            "CatBook",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Amatic',
              fontSize: 35,
              letterSpacing: 5,
            ),
          ),
        ),
        actions: <Widget>[
          NeumorphicButton(
            child: Icon(Icons.account_circle),
            style: NeumorphicStyle(
              depth: 5,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
//          padding: EdgeInsets.all(15.0),
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ImagePickerPage(),
                ));
              },
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
        .then((data) {
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
  void initState() {
    //  this code calls getImage function.
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: decideGridTileWidget());
  }
}

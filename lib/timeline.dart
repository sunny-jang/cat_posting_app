//import 'dart:html';
import 'dart:typed_data';

import 'package:catpostingapp/imagePickerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});

  final String email;

  List<Widget> makeImagesList() {
    List<Widget> imageItems = [
      postItem(),
      postItem(),
    ];

    return imageItems;
  }

  Widget postItem() {
    return Neumorphic(
      margin: EdgeInsets.only(top: 30),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        depth: -5,
        lightSource: LightSource.topLeft,
        color: Color(0xffe9eff5),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
            ),
            Neumorphic(
              margin: EdgeInsets.only(bottom: 10),
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
              ),
              child: ImageGridItem(1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "My cuteass cat for this Catbook app  #극동이",
                style: TextStyle(
//                fontFamily: 'Amatic',
//                fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
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
          child: SvgPicture.asset("assets/logo.svg", color: Colors.blue, height: 100)
        ),
        actions: <Widget>[
          NeumorphicButton(
            child: Icon(Icons.flight_takeoff),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
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
      bottomNavigationBar: Neumorphic(
//        style: NeumorphicStyle(
//          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
//        ),
        child: BottomAppBar(
          color: Color(0xfff4f5f9),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NeumorphicButton(
                  child: Icon(Icons.home),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    depth: 5,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                NeumorphicButton(
                  child: Icon(Icons.add),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ImagePickerPage(),
                    ));
                  },
                ),
                NeumorphicButton(
                  child: Icon(Icons.exit_to_app),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    color: Colors.white,
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text("Home"),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.add_circle),
//            title: Text("New"),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.people),
//            title: Text("Sign Out"),
//          ),
//        ],
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

//import 'dart:html';
import 'dart:typed_data';

import 'package:catpostingapp/imagePickerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_svg/svg.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});

  final dbRef = FirebaseDatabase.instance.reference().child("posts");
  final String email;

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
            child: SvgPicture.asset("assets/logo.svg",
                color: Colors.blue, height: 100)),
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
      body: FutureBuilder(
          future: dbRef.child("cat_list").orderByChild("uploadTime").startAt('1').once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            var lists = [];
            if (snapshot.hasData) {
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, value) {
                lists.add(value);
              });
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Neumorphic(
                    margin: EdgeInsets.only(top: 30),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(30)),
                      depth: -5,
                      lightSource: LightSource.topLeft,
                      color: Color(0xffe9eff5),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/cat-avatar2.jpg'),
                                radius: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                lists[index]["userEmail"].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Neumorphic(
                            margin: EdgeInsets.only(top: 15, bottom: 10),
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(30)),
                            ),
                            child:
                                Image.network(lists[index]["image"].toString()),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              lists[index]["des"].toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      bottomNavigationBar: Neumorphic(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImagePickerPage(),
                      ),
                    );
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
        ),
      ),
    );
  }
}




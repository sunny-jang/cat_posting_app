import 'package:catpostingapp/imagePickerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Timeline extends StatelessWidget {
  Timeline({this.email});

  final dbRef = FirebaseDatabase.instance.reference().child("posts");
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        color: Color(0xffe9eff5),
        leading: NeumorphicButton(
          child: Icon(
            Icons.camera_alt,
            color: Colors.grey[700],
          ),
          style: NeumorphicStyle(
            depth: 5,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          ),
          onPressed: () {},
        ),
        title: Center(
            child: Image.asset("assets/logo.png", width: 150,),
        ),
        actions: <Widget>[
          NeumorphicButton(
            child: Icon(Icons.flight_takeoff, color: Colors.grey[700]),
            style: NeumorphicStyle(
              depth: 5,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Color(0xffe9eff5),
        child: FutureBuilder(
          future: dbRef
              .child("cat_list")
              .orderByChild("uploadTime")
              .startAt('1')
              .once(),
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
                    shape: NeumorphicShape.convex,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                    depth: 10,
                    intensity: 0.7,
                    lightSource: LightSource.bottomLeft,
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
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  lists[index]["userEmail"].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.menu),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            lists[index]["des"].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            lists[index]["uploadTime"].toString(),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Neumorphic(
        child: BottomAppBar(
          color: Color(0xffe9eff5),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NeumorphicButton(
                  child: Icon(Icons.home, color: Colors.grey[700]),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    intensity: 1,
                    surfaceIntensity: 0.5,
                    depth: 5,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                    color: Colors.white,
                    lightSource: LightSource.topLeft,
                  ),
                  onPressed: () {},
                ),
                NeumorphicButton(
                  child: Icon(Icons.add, color: Colors.grey[700]),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    color: Colors.white,
                    intensity: 0.7,
                    surfaceIntensity: 0.5,
                    shape: NeumorphicShape.flat,
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
                  child: Icon(Icons.exit_to_app, color: Colors.grey[700]),
                  padding: EdgeInsets.all(16),
                  style: NeumorphicStyle(
                    color: Colors.white,
                    intensity: 1,
                    surfaceIntensity: 0.5,
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

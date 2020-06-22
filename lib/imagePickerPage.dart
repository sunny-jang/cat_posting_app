
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[100],
              child: Image(
                height: 300,
                image: AssetImage('assets/placeholder-client.png'),
                color: Colors.grey[500],
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

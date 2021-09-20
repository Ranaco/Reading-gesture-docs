// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Image picker',
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImagePicker picker = ImagePicker();
  String imagePath = "";
  String cameraPath = "";
  Future onClick() async {
    final imagePicker = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      setState(() {
        imagePath = imagePicker.path;
      });
    }
  }

  Future onCamera() async {
    final camera = await picker.pickImage(source: ImageSource.camera);
    if (camera != null) {
      setState(() {
        cameraPath = camera.path;
      });
    }
  }

  Future<void> _openDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: StadiumBorder(),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                      child: Text(
                    'Take a photo',
                  ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Image Picker'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          imagePath != ""
              ? Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(imagePath),
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(300.0)),
                  ),
                )
              : imagePath == null
                  ? Container()
                  : cameraPath != ""
                      ? Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(imagePath),
                              ),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(300.0)),
                          ),
                        )
                      : Container(),
          MaterialButton(
            onPressed: onClick,
            child: Text(
              'Pick Image',
              style: TextStyle(color: Colors.grey),
            ),
            color: Colors.grey.shade900,
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: _openDialogBox,
            child: Text(
              'Upload from camera',
              style: TextStyle(color: Colors.grey),
            ),
            color: Colors.grey.shade900,
          )
        ],
      )),
    );
  }
}

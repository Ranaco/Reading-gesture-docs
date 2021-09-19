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

  Future onClick() async {
    final imagePicker = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      setState(() {
        imagePath = imagePicker.path;
      });
    }
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
              : Container(),
          MaterialButton(
            onPressed: onClick,
            child: Text(
              'Pick Image',
              style: TextStyle(color: Colors.grey),
            ),
            color: Colors.grey.shade900,
          ),
        ],
      )),
    );
  }
}

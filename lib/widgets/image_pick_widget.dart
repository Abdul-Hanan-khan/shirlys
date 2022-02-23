import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  File file;
  MyImagePicker(this.file);

  @override
  _MyimagePickerState createState() => _MyimagePickerState();
}

class _MyimagePickerState extends State<MyImagePicker> {
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
        onTap:pickImageDialog,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            widget.file==null?Container(
              width: double.maxFinite,
              height: 200,
              padding: EdgeInsets.all(10),
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 65,
                    color: Colors.grey,
                  ),
                  Text("Add Attatchment")
                ],
              ),
            )
                :Container(
              height: 200,
              width: double.maxFinite,
              child: Image.file(File(widget.file.path),

                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap:(){
                  pickImageDialog();
                  // _openGallery(true);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white38,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        )

    );
  }

  Future<void> _openGallery(bool openGallary)  {
    ImagePicker().getImage(
        source: openGallary ? ImageSource.gallery : ImageSource.camera,
        imageQuality: 15).then((imageFile) {
      setState(() {
        widget.file = File(imageFile.path);
      });
    });
  }

  pickImageDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("Complete Action Using"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openGallery(true);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.pink,
                        size: 30,
                      ),
                      Text("Gallery")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _openGallery(false);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.pink,
                        size: 30,
                      ),
                      Text("Camera")
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
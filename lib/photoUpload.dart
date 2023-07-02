import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircularPhotoUploader extends StatefulWidget {
  @override
  _CircularPhotoUploaderState createState() => _CircularPhotoUploaderState();
}

class _CircularPhotoUploaderState extends State<CircularPhotoUploader> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
      }
    });
    Navigator.of(context).pop(); // Close the dialog after selecting an image
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Select Image'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text('Gallery'),
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: _imageFile != null
            ? ClipOval(
          child: Image.file(
            _imageFile!,
            fit: BoxFit.cover,
          ),
        )
            : Icon(
          Icons.camera_alt,
          color: Colors.grey[600],
          size: 40,
        ),
      ),
    );
  }
}

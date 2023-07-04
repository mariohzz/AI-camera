import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:python_project/photourlprovider.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';

class CircularPhotoUploader extends StatefulWidget {
  final UserDatabase userDatabase;
  CircularPhotoUploader(this.userDatabase);

  @override
  _CircularPhotoUploaderState createState() => _CircularPhotoUploaderState();
}

class _CircularPhotoUploaderState extends State<CircularPhotoUploader> {
  File? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    setState(() {
      if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        _isLoading = true; // Show loading indicator
      }
    });
    widget.userDatabase.uploadPhoto(_imageFile!).then((photoUrl) {
      final photoUrlProvider =
      Provider.of<PhotoUrlProvider>(context, listen: false);
      photoUrlProvider.photoUrl = photoUrl;
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      // Show info dialog
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Photo Uploaded'),
            content: Text('The photo has been successfully uploaded.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    });
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
                        Navigator.of(dialogContext).pop(); // Close the dialog
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        Navigator.of(dialogContext).pop(); // Close the dialog
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
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Consumer<PhotoUrlProvider>(
              builder: (context, photoUrlProvider, _) {
                return photoUrlProvider.photoUrl != null
                    ? ClipOval(
                  child: Image.network(
                    photoUrlProvider.photoUrl!,
                    fit: BoxFit.cover,
                  ),
                )
                    : _imageFile != null
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
                );
              },
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserPhotoUploader extends StatefulWidget {
  final String userId;
  final Function(String) onPhotoUploaded;

  UserPhotoUploader({required this.userId, required this.onPhotoUploaded});

  @override
  _UserPhotoUploaderState createState() => _UserPhotoUploaderState();
}

class _UserPhotoUploaderState extends State<UserPhotoUploader> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage != null) {
      try {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('user_photos/${widget.userId}.jpg');
        UploadTask uploadTask = storageReference.putFile(_selectedImage!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String photoDownloadUrl = await taskSnapshot.ref.getDownloadURL();
        widget.onPhotoUploaded(photoDownloadUrl);
      } catch (e) {
        print('Error uploading photo: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedImage != null) ...[
          Image.file(_selectedImage!),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Save Photo'),
          ),
        ] else ...[
          Text('No photo selected'),
          ElevatedButton(
            onPressed: () => _pickImage(ImageSource.gallery),
            child: Text('Pick Photo'),
          ),
        ],
      ],
    );
  }
}

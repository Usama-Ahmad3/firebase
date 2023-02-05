import 'dart:io';

import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerr extends StatefulWidget {
  const ImagePickerr({Key? key}) : super(key: key);

  @override
  State<ImagePickerr> createState() => _ImagePickerrState();
}

class _ImagePickerrState extends State<ImagePickerr> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImageGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        Utils().toastMessage('Image not picked!');
      }
    });
  }

  bool loading = false;
  final auth = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Icon(Icons.image),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              RoundButton(
                  title: 'Upload',
                  loading: loading,
                  ontap: () async {
                    setState(() {
                      loading = true;
                    });
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/usama/${DateTime.now().millisecondsSinceEpoch}');
                    firebase_storage.UploadTask upload =
                        ref.putFile(_image!.absolute);
                    await Future.value(upload).then((value) {
                      Utils().toastMessage('Uploaded');
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(error.toString());
                    });
                    var url = await ref.getDownloadURL();
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    auth.child(id).set({'id': id, 'title': url.toString()});
                  })
            ],
          ),
        ),
      ),
    );
  }
}

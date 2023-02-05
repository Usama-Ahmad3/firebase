import 'dart:io';

import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (picked != null) {
        _image = File(picked.path);
      }
    });
  }

  final auth = FirebaseDatabase.instance.ref('post');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picker'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  getImage();
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
              RoundButton(
                  title: 'Uploaded',
                  loading: loading,
                  ontap: () async {
                    setState(() {
                      loading = true;
                    });
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/ahmad/${DateTime.now().millisecondsSinceEpoch}');
                    firebase_storage.UploadTask upload =
                        ref.putFile(_image!.absolute);
                    await Future.value(upload).then((value) {
                      Utils().toastMessage('Uploaded');
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                    var url = await ref.getDownloadURL();
                    auth.child('3').set({'id': 4, 'title': url.toString()});
                  })
            ],
          ),
        ),
      ),
    );
  }
}

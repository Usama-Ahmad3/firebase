import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view/utils.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class AddFireStore extends StatefulWidget {
  const AddFireStore({Key? key}) : super(key: key);

  @override
  State<AddFireStore> createState() => _AddFireStoreState();
}

class _AddFireStoreState extends State<AddFireStore> {
  var controler = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('usama');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add FireStore'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: controler,
              maxLines: 3,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What is in your mind?'),
            ),
            const SizedBox(height: 30),
            RoundButton(
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore
                    .doc(id)
                    .set({'title': controler.text.toString(), 'id': id}).then(
                        (value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage('Post Added');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              },
              title: 'Add',
            )
          ],
        ),
      ),
    );
  }
}
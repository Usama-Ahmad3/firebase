import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var controler = TextEditingController();
  bool loading = false;
  var ref = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                setState(() {
                  loading = true;
                });
                ref
                    .child(id)
                    .set({'title': controler.text.toString(), 'id': id}).then(
                        (value) {
                  Utils().toastMessage('PostAdded');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
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

import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/round_button.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({Key? key}) : super(key: key);

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose'), actions: [
        IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.login_outlined))
      ]),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          RoundButton(
            title: 'Firebase RealTime',
            ontap: () {
              Navigator.pushNamed(context, RoutesName.post);
            },
          ),
          SizedBox(height: 30),
          RoundButton(
              title: 'Firebase FireStore',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.firestore);
              }),
          SizedBox(height: 30),
          RoundButton(
              title: 'Firebase Storage',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.imagePicker);
              }),
          SizedBox(height: 30),
          RoundButton(
              title: 'Firebase Storage Camera',
              ontap: () {
                Navigator.pushNamed(context, RoutesName.cameraPicker);
              })
        ]),
      )),
    );
  }
}

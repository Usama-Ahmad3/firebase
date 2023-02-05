import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final reset = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            controller: reset,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'admin@gmail.com',
                label: Text('Enter Email')),
          ),
          SizedBox(height: 40),
          RoundButton(
              title: 'Reset',
              loading: loading,
              ontap: () {
                setState(() {
                  loading = true;
                });
                auth
                    .sendPasswordResetEmail(email: reset.text.toString())
                    .then((value) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(
                      'Password Reset Link Send Please Check Your Email');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              })
        ],
      )),
    );
  }
}

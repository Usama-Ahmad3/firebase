import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  var phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: '+1 234 5678912'),
            ),
            RoundButton(
              title: 'Login',
              ontap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text.toString(),
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().toastMessage(e.toString());
                    },
                    codeSent: (String verification, int? token) {
                      Navigator.pushNamed(context, RoutesName.verifyphone,
                          arguments: {
                            'verificationid': verification.toString()
                          });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastMessage(e.toString());
                    });
              },
              loading: loading,
            )
          ],
        ),
      ),
    );
  }
}

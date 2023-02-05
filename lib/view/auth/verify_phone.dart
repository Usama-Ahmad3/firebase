import 'package:firebase/routes/routesname.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class VerifyPhone extends StatefulWidget {
  dynamic verificationid;
  VerifyPhone({Key? key, required this.verificationid}) : super(key: key);

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  var verify = TextEditingController();
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: SafeArea(
        child: Column(children: [
          TextFormField(
            controller: verify,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter 6 Digit code'),
          ),
          RoundButton(
            title: 'Verify',
            ontap: () async {
              setState(() {
                loading = true;
              });
              final credetials = PhoneAuthProvider.credential(
                  verificationId: widget.verificationid['verificationid'],
                  smsCode: verify.text.toString());
              try {
                await auth.signInWithCredential(credetials);
                Navigator.pushNamed(context, RoutesName.post);
              } catch (e) {
                setState(() {
                  loading = false;
                });
              }
            },
            loading: loading,
          )
        ]),
      ),
    );
  }
}

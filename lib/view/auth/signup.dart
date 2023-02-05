import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: camel_case_types
class Signup_screen extends StatefulWidget {
  const Signup_screen({Key? key}) : super(key: key);

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

// ignore: camel_case_types
class _Signup_screenState extends State<Signup_screen> {
  bool loading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final Key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    if (Key.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
      // Navigator.pushNamed(context, RoutesName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SignUp Screen'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150),
            child: Form(
              key: Key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.alternate_email),
                        hintText: 'Email',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  RoundButton(
                      title: 'Signup',
                      loading: loading,
                      ontap: () {
                        signUp();
                      }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Already Have Acoount?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.login);
                          },
                          child: const Text('SignIn'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

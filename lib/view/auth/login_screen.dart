import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/utils.dart';
import 'package:firebase/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final Key = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void logIn() {
    if (Key.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .signInWithEmailAndPassword(
              email: emailController.text.toString(),
              password: passwordController.text.toString())
          .then((value) {
        Utils().toastMessage(value.user!.email.toString());
        Navigator.pushNamed(context, RoutesName.post);
        setState(() {
          loading = false;
        });
      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150),
          child: Form(
            key: Key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.forget);
                      },
                      child: const Text(
                        'Forget password',
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                const SizedBox(height: 30),
                RoundButton(
                    loading: loading,
                    title: 'Login',
                    ontap: () {
                      logIn();
                    }),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text("Don't Have Account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.signup);
                        },
                        child: const Text('Sign Up'))
                  ],
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.phone);
                    },
                    child: const Text('Login With phone',
                        style: TextStyle(fontSize: 20)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

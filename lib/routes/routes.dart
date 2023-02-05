import 'package:firebase/routes/routesname.dart';
import 'package:firebase/view/auth/forgotpassword.dart';
import 'package:firebase/view/auth/login_phone.dart';
import 'package:firebase/view/auth/login_screen.dart';
import 'package:firebase/view/auth/signup.dart';
import 'package:firebase/view/auth/verify_phone.dart';
import 'package:firebase/view/controller.dart';
import 'package:firebase/view/firestore/add_fireStore.dart';
import 'package:firebase/view/firestore/firestore_list.dart';
import 'package:firebase/view/posts/add_post.dart';
import 'package:firebase/view/posts/image_picker.dart';
import 'package:firebase/view/posts/picker.dart';
import 'package:firebase/view/posts/post_screen.dart';
import 'package:firebase/view/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const Splash(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Signup_screen());
      case RoutesName.post:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PostScreen());
      case RoutesName.verifyphone:
        return MaterialPageRoute(
            builder: (BuildContext context) => VerifyPhone(
                  verificationid: settings.arguments as Map,
                ));
      case RoutesName.phone:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginPhone());
      case RoutesName.addPost:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddPost());
      case RoutesName.firestore:
        return MaterialPageRoute(
            builder: (BuildContext context) => FireStore());
      case RoutesName.addfirestore:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddFireStore());
      case RoutesName.imagePicker:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ImagePickerr());
      case RoutesName.cameraPicker:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Picker());
      case RoutesName.controller:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ControllerScreen());
      case RoutesName.forget:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Forgot());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
              body: Center(child: Text('Routes Not Defined')));
        });
    }
  }
}

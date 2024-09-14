// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_smit/Auth%20Screens/login.dart';
import 'package:to_do_list_smit/Screens/hidden_drawer.dart';
import 'package:to_do_list_smit/Utils/push_replace.dart';

class SplashService {
  void isLogin(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        pushReplace(context, const HiddenDrawer());
      } else {
        pushReplace(context, Login());
      }
    });
  }
}

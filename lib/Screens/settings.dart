import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Auth%20Screens/login.dart';
import 'package:to_do_list_smit/Auth%20Screens/signup.dart';
import 'package:to_do_list_smit/Custom%20Widgets/toast.dart';
import 'package:to_do_list_smit/Utils/colors.dart';
import 'package:to_do_list_smit/Utils/push_replace.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
            title: Text(
              'Logout',
              style: GoogleFonts.poppins(
                  fontSize: 20, color: appcolor, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.keyboard_arrow_right_outlined),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () {
                                auth.signOut().then((value) {
                                  pushReplace(context, const Login());
                                  ToastPopUp().toast('Logout successfully',
                                      Colors.green, Colors.white);
                                }).onError((error, v) {
                                  ToastPopUp().toast(error.toString(),
                                      Colors.green, Colors.white);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Ok'))
                        ],
                      );
                    });
              },
            ),
          ),
          ListTile(
            leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
            title: Text(
              'Delete',
              style: GoogleFonts.poppins(
                  fontSize: 20, color: appcolor, fontWeight: FontWeight.bold),
            ),
            trailing: SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_outlined),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Delete Account',
                            style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          content: Text(
                            'Are you sure you want to Delete account?',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  auth.currentUser!.delete().then((v) {
                                    ToastPopUp().toast(
                                        'Account deleted successfully',
                                        Colors.red,
                                        Colors.white);
                                    pushReplace(context, const Signup());
                                  }).onError((error, v) {
                                    print(error);
                                    ToastPopUp().toast(error.toString(),
                                        Colors.red, Colors.white);
                                  });
                                },
                                child: const Text('Ok'))
                          ],
                        );
                      });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

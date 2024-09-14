import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Auth%20Screens/login.dart';
import 'package:to_do_list_smit/Custom%20Widgets/auth_text_field.dart';
import 'package:to_do_list_smit/Custom%20Widgets/button.dart';
import 'package:to_do_list_smit/Custom%20Widgets/password_text_field.dart';
import 'package:to_do_list_smit/Custom%20Widgets/toast.dart';
import 'package:to_do_list_smit/Utils/colors.dart';
import 'package:to_do_list_smit/Utils/nav_push.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String fullname = '', firstname = '', lastname = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.poppins(
                      color: black, fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  'Create your account',
                  style: GoogleFonts.poppins(
                      color: lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                SimpleAuthTextField(
                    myController: firstName,
                    keyboardType: TextInputType.name,
                    labelText: 'First Name'),
                SizedBox(height: 10),
                SimpleAuthTextField(
                    myController: lastName,
                    keyboardType: TextInputType.name,
                    labelText: 'Last Name '),
                SizedBox(height: 10),
                SimpleAuthTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    myController: emailController,
                    labelText: 'Email'),
                SizedBox(height: 10),
                SimpleAuthTextField(
                    keyboardType: TextInputType.phone,
                    labelText: 'Mobile Number'),
                SizedBox(height: 10),
                SimpleAuthTextField(
                    keyboardType: TextInputType.text, labelText: 'Gender'),
                SizedBox(height: 10),
                PasswordTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    myController: passwordController,
                    labelText: 'Password'),
                SizedBox(height: 10),
                PasswordTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Confirm Password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    myController: confirmController,
                    labelText: 'Confirm Password'),
                SizedBox(height: 20),
                CustomButton(
                    buttonWidth: 400,
                    buttonHeight: 50,
                    buttonFontSize: 17,
                    buttonText: 'Sign Up',
                    isLoading: isLoading,
                    onPressed: () {
                      setState(() {
                        const String pattern =
                            r'^[a-zA-Z0-9._%+-a-zA-Z0-9]+@(gmail|hotmail|yahoo|outlook|[a-zA-Z0-9.-]+)\.com$';
                        final RegExp regex = RegExp(pattern);

                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ToastPopUp().toast("Please fill all the fields",
                                Colors.amber, Colors.white);

                            setState(() {
                              isLoading = false;
                            });
                          } else if (passwordController.text !=
                              confirmController.text) {
                            ToastPopUp().toast(
                                "Please ensure your passwords are identical.",
                                Colors.red,
                                Colors.white);

                            setState(() {
                              isLoading = false;
                            });
                          } else if (!regex.hasMatch(emailController.text)) {
                            ToastPopUp().toast(
                                "Please provide a valid email address",
                                Colors.blueGrey,
                                Colors.white);

                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            auth
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                                .then((value) async {
                              setState(() {
                                isLoading = false;
                              });

                              // firstname = firstName.text.trim();
                              // lastname = lastName.text.trim();
                              // fullname = firstname + lastname;
                              // DatabaseReference db =
                              //     FirebaseDatabase.instance.ref('Todo');
                              // String id = DateTime.now()
                              //     .millisecondsSinceEpoch
                              //     .toString();
                              // db.child(id).set({
                              //   'id': id,
                              //   'name': fullname,
                              // }).then((value) {
                              //   setState(() {
                              //     isLoading = false;
                              //   });
                              // }).onError((error, v) {
                              //   ToastPopUp().toast(
                              //       error.toString(), Colors.red, Colors.white);
                              // });

                              // String userId =
                              //     FirebaseAuth.instance.currentUser!.uid;

                              // DatabaseReference db = FirebaseDatabase.instance
                              //     .ref('Users')
                              //     .child(userId);

                              // db.set({
                              //   'firstName': firstName,
                              //   'lastName': lastName,
                              // }).onError((error, v) {
                              //   ToastPopUp().toast('Enter first and last name',
                              //       Colors.red, Colors.white);
                              // });
                              ToastPopUp().toast(
                                  "Account created successfully!",
                                  Colors.green,
                                  Colors.white);

                              // ignore: use_build_context_synchronously
                              navPush(context, const Login());
                            }).onError((error, v) {
                              setState(() {
                                isLoading = false;
                              });

                              String errorMessage = 'An error occurred';
                              if (error
                                  .toString()
                                  .contains('email-already-in-use')) {
                                errorMessage = 'Email already exists';
                              } else if (error
                                  .toString()
                                  .contains('invalid-email')) {
                                errorMessage = 'Invalid email address';
                              } else if (error
                                  .toString()
                                  .contains('weak-password')) {
                                errorMessage = 'The password is too weak';
                              }
                              ToastPopUp().toast(
                                  errorMessage, Colors.red, Colors.white);
                            });
                          }
                        }
                      });
                    }),
                SizedBox(
                  height: 15,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.lato(color: black, fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {
                      navPush(context, const Login());
                    },
                    child: Text(
                      'SignIn',
                      style: GoogleFonts.lato(color: appcolor, fontSize: 20),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Auth%20Screens/signup.dart';
import 'package:to_do_list_smit/Custom%20Widgets/auth_text_field.dart';
import 'package:to_do_list_smit/Custom%20Widgets/button.dart';
import 'package:to_do_list_smit/Custom%20Widgets/password_text_field.dart';
import 'package:to_do_list_smit/Custom%20Widgets/toast.dart';
import 'package:to_do_list_smit/Screens/hidden_drawer.dart';
import 'package:to_do_list_smit/Utils/colors.dart';
import 'package:to_do_list_smit/Utils/nav_push.dart';
import 'package:to_do_list_smit/Utils/push_replace.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
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
                SizedBox(height: 40),
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.poppins(
                      color: black, fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Text(
                  'Sign in with your email',
                  style: GoogleFonts.poppins(
                      color: lightGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
                SizedBox(height: 20),
                SizedBox(height: 15),
                SimpleAuthTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    }
                    return null;
                  },
                  myController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                ),
                SizedBox(height: 10),
                PasswordTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                  myController: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  labelText: 'Password',
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 100, bottom: 30),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(color: lightGrey),
                    ),
                  ),
                ),
                CustomButton(
                  buttonWidth: 400,
                  buttonHeight: 50,
                  buttonFontSize: 17,
                  buttonText: 'Login',
                  isLoading: isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      auth
                          .signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                          .then((value) {
                        setState(() {
                          isLoading = false;
                        });
                        ToastPopUp().toast(
                            'Login Successfull', Colors.green, Colors.white);
                        pushReplace(context, HiddenDrawer());
                      }).onError((error, v) {
                        setState(() {
                          isLoading = false;
                        });
                        String errorMessage = 'An error occurred';
                        if (error.toString().contains('wrong-password')) {
                          errorMessage = 'Incorrect password';
                        } else if (error
                            .toString()
                            .contains('user-not-found')) {
                          errorMessage = 'User not found';
                        } else {
                          errorMessage = 'Email or password is incorrect';
                        }

                        ToastPopUp()
                            .toast(errorMessage, Colors.red, Colors.white);
                      });
                    }
                  },
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.lato(color: black, fontSize: 18),
                    ),
                    InkWell(
                      onTap: () {
                        navPush(context, const Signup());
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.lato(color: appcolor, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Or Sign In with ',
                    style: GoogleFonts.poppins(
                        color: darkblue, fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: black,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            color: white,
                          )),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: white,
                          )),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkblue,
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FontAwesomeIcons.facebookF,
                            color: white,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

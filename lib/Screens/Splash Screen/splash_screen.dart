import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Firebase%20Service/splash_service.dart';
import 'package:to_do_list_smit/Utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashService().isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
                text: TextSpan(
                    style:
                        GoogleFonts.roboto(color: Colors.white, fontSize: 23),
                    children: [
                  const TextSpan(
                      text: 'Your To Do ',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'List',
                      style: GoogleFonts.poppins(
                          fontSize: 30, fontWeight: FontWeight.bold))
                ]))
          ],
        ),
      ),
    );
  }
}

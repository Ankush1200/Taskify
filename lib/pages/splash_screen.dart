import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:todo/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _goToHomePage() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
    return;
  }

  @override
  void initState() {
    Logger().i("Route to -> Splash Screen");
    Future.delayed(
      const Duration(seconds: 3),
      () {
        _goToHomePage();
        return;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Taskify",
              style: GoogleFonts.mooli(
                color: Colors.amberAccent.shade100,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Your Own TODO App",
              textAlign: TextAlign.center,
              style: GoogleFonts.mooli(
                color: Colors.amberAccent.shade100,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width/1.5,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "©Ankush Prajapati All rights reserved!",
                textAlign: TextAlign.center,
                style: GoogleFonts.mooli(
                  color: Colors.amberAccent.shade100,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naughty_notes/auth_service.dart';
import 'package:naughty_notes/login_screen.dart';
import 'package:naughty_notes/notes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), (){
     if(AuthService().getInstance().currentUser != null){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesScreen()));
     }else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginScreen()));
     }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Naughty",
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          color: Colors.black, // Shadow color
                          offset: Offset(2, 2), // Position (X, Y)
                          blurRadius: 5, // Blur effect
                        ),
                      ],
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                      color: Color(0XFF6FF436)),
                  children: [
                    TextSpan(
                        text: " Notes",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: Color(0XFFC22A41)))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

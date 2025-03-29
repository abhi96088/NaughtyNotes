import 'dart:async';

import 'package:flutter/material.dart';
import 'package:naughty_notes/services/auth_service.dart';
import 'package:naughty_notes/screens/login_screen.dart';
import 'package:naughty_notes/screens/notes_screen.dart';
import 'package:naughty_notes/widgets/texts.dart';

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
            Texts.appTitle
          ],
        ),
      ),
    );
  }
}

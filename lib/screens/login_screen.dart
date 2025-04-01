import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naughty_notes/services/auth_service.dart';
import 'package:naughty_notes/screens/notes_screen.dart';
import 'package:naughty_notes/widgets/texts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //------------>  background <-----------------//
      body: Container(
        height: screenHeight,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFFFF1493),
                  Color(0xFF1E90FF),
                  Color(0xFF8A2BE2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.5, 0.9])),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              SizedBox(
                height: screenHeight * 0.5,
                width: screenWidth * 0.9,
                child: SvgPicture.asset(
                  "assets/images/login_art.svg",
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              ///////////////////////////// Card //////////////////////
              SizedBox(
                height: screenHeight * 0.3,
                width: screenWidth * 0.95,
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: screenHeight * 0.06,
                            child: FittedBox(child: Texts.appTitle)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text(
                          "Write Freely, Store Secretly!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Text(
                          "Get Started",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        SizedBox(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.7,
                          child: ElevatedButton(

                            ///////////// login code ///////////
                              onPressed: () async {
                                final signIn =
                                    await AuthService().signInWithGoogle();

                                if (signIn != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NotesScreen()));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Something went wrong... try again..!")));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: Colors.blueAccent),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Image.asset(
                                      "assets/images/google.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Continue with Google",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

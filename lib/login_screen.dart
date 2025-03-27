import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naughty_notes/auth_service.dart';
import 'package:naughty_notes/notes_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
           stops: [0.1, 0.5, 0.9]
        )),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              SvgPicture.asset("assets/images/login_art.svg", ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  child: Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      ),
                      SizedBox(height: 10,),
                      Text("Write Freely, Store Secretly!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),),
                      SizedBox(height: 10,),
                      Text("Get Started", style: TextStyle(
                        color: Colors.deepPurple, fontSize: 22, fontWeight: FontWeight.w600
                      ),),
                      SizedBox(height: 10,),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(onPressed: () async{
                          final signIn = await AuthService().signInWithGoogle();

                          if(signIn != null){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesScreen()));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Something went wrong... try again..!"))
                            );
                          }
                        },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              backgroundColor: Colors.blueAccent
                            ),
                            child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Spacer(),
                            Image.asset("assets/images/google.png",height: 30, width: 30,),
                            Spacer(),
                            Text("Continue with Google", style: TextStyle(color: Colors.white, fontSize: 18),),
                            Spacer(),
                          ],
                        ),
                                            )),
                      )],
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

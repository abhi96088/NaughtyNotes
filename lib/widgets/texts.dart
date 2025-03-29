import 'package:flutter/material.dart';

class Texts{

  static RichText appTitle = RichText(
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
  );
}
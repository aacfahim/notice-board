import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notice_board/utils/const.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //     decoration: BoxDecoration(
      //   image: DecorationImage(image: AssetImage("assets/NU_logo.png")),
      // )),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("National University Notice Application",
                  style: TextStyle(color: PRIMARY_COLOR)),
              SizedBox(height: 10),
              CircularProgressIndicator(),
            ],
          )),
    );
  }
}

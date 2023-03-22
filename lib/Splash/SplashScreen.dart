import 'dart:async';
import 'package:automated_attendance_system/Authentication/SignIn.dart';
import 'package:automated_attendance_system/Home_Screen/Home.dart';
import 'package:automated_attendance_system/Home_Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreenfirest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if(user.isNull){
      Timer(Duration(seconds: 5),()=> Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>SignIn())));

    }
    else{
      Timer(Duration(seconds: 5),()=> Get.offAll(Home()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(width: 220,
                  height: 220,
                  child: Image.asset('assets/time-and-attendance.png')
              ),
            ),

            SizedBox(
              height: 10,
            ),
            //   Text("FCM by DOTCODER")
//
          ],
        ),
      ),
    );
  }
}
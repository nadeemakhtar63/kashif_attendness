import 'dart:io';
import 'package:automated_attendance_system/Home_Screen/Home.dart';
import 'package:automated_attendance_system/Home_Screen/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../Authentication/SignIn.dart';
import '../Constant/AuthConstant.dart';
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
class AuthController extends GetxController {
  RxBool sharebox = false.obs;
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  // Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>([]);
  // List<TodoModel> get todos => todoList.value;

  // Rx<List<ContectModel>> contectList = Rx<List<ContectModel>>([]);
  // List<ContectModel> get contects => contectList.value;

  // late Rx<GoogleSignInAccount?> googleSignInAccount;
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
  }
  register(String email, password, name) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        await firebaseFirestore.collection("user").
        doc(auth.currentUser!.uid)
            .set({
          'image': null,
          'name':name,
          'username': '',
          'email': email,
          'uid': auth.currentUser!.uid,

        });
        //     return "Sign In Sucessfully";
        Get.offAll(()=>Home());
        Get.snackbar("Response", "SignIn Sucessfully");
        // box.write("userid", user);
      }
    } catch (firebaseAuthException) {
      authProblems? errorType;
      if (Platform.isAndroid) {
        switch (firebaseAuthException) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error ( such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
        // ...
          default:
            Get.snackbar("Response", "$firebaseAuthException");
            print('Case ${firebaseAuthException} is not yet implemented');
        }
      }
      print('The error is $errorType');
      // Get.snackbar("Response",'$errorType' );
      // return "$errorType";
    }
  }
guestuser() async
{
  try {
    final userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    print("Signed in with temporary account.");
    Get.offAll(Home());
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        print(e.code.toString());
    }
  }
}
  login(String email, password,key) async {
    try {
     UserCredential user= await auth.signInWithEmailAndPassword(email: email, password: password);
      if(user!=null)
        {
          // if(key==1)
          // {
          //   Get.offAll(() => ForkScreen());
          // }
          // else
          //   {
              Get.offAll(() => Home());
            // }
        }
    } catch (firebaseAuthException) {
      Get.snackbar("Response", "$firebaseAuthException");
    }
  }
 signout()async{
    await auth.signOut();
    Get.to(SignIn());
  }

  Future resetPassword(emails) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emails);
      Get.snackbar('Response','Password reset link sent');
    } on FirebaseAuthException catch (e) {
      Get.snackbar("response","${e.message.toString()}");
      return;
    }
  }
}
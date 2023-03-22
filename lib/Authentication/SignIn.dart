import 'package:automated_attendance_system/Authentication/NewAccount.dart';
import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Widgets/EvelutedButton.dart';
import 'package:automated_attendance_system/Widgets/textfildfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import '../Controller/authcontroller.dart';
import 'ForgetPassword.dart';
class SignIn extends StatefulWidget {
  final signin;
  const SignIn({Key? key,this.signin}) : super(key: key);
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  bool emailvalidate=false;
  bool passwordvalidate=false;
  bool texthidecheck=true;
  void initState() {
    Get.put(AuthController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign In".tr,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
            SizedBox(height: 20,),
            textField(
                emailEditingController:_emailController,
                emailvalidate:emailvalidate,
                hintText: 'Email'.tr,
                textInputType: TextInputType.emailAddress,
                check:false,
                ),
            textField(
              emailEditingController:_passwordController,
              emailvalidate:passwordvalidate,
              hintText: 'Password'.tr,
              textInputType: TextInputType.emailAddress,
              check:texthidecheck,
            ),
            Row(
              children: [
                Checkbox(
                    value: texthidecheck,
                    onChanged:(changing){
                  setState(() {
                    texthidecheck=changing!;
                  });
                    }),
                Text("Hide".tr)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 42,
              child: myElevatedButton(
                  color: Color(0xC4C4C4),
                  onPressed: (){
                if((_emailController.text.isEmpty )||(_passwordController.text.isEmpty)){
                  setState(() {
                  _emailController.text.isEmpty?emailvalidate=true:emailvalidate=false;
                  _passwordController.text.isEmpty?passwordvalidate=true:passwordvalidate=false;
                  });
                }
                else{
                  authController.login(_emailController.text,_passwordController.text,widget.signin==null?0:1);
                }

                  },
                  child: Text("Sign In".tr,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w900),)
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
                onTap: (){
                  Get.to(ForgetPassword());
                },
                child: Text("Forgot your password?".tr,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w900),))
            ,SizedBox(height: 20,),
            InkWell(
              onTap: (){
                Get.to(CreateNewAccount());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create New account?".tr,style: TextStyle(fontSize: 14,color: Colors.black),)
                  , InkWell(
                      onTap: (){
                        Get.to(CreateNewAccount());
                      },
                      child: Text("Create Account".tr,style: TextStyle(fontSize: 14,color: Colors.blueAccent),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

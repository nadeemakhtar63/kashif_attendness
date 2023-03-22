import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constant/AuthConstant.dart';
import '../Widgets/EvelutedButton.dart';
import '../Widgets/textfildfunction.dart';
import 'SignIn.dart';
class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  // const ForgetPassword({Key? key}) : super(key: key);
TextEditingController _emailController=new TextEditingController();

bool emailvalidate=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black12,elevation: 0.0,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Forgot your password?".tr,style:
          TextStyle(fontSize: 30,fontWeight: FontWeight.w900
          ),)),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Enter your email below and we’ll send you a link to your email to reset your password".tr,style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),),
          ),
          textField(
            emailEditingController:_emailController,
            emailvalidate:emailvalidate,
            hintText: 'Email'.tr,
            textInputType: TextInputType.emailAddress,
            check:false,
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width*0.8,
            height: 42,
            child: myElevatedButton(
                color: Color(0xC4C4C4),
                onPressed: (){
                  if(_emailController.text.isEmpty ){
                    setState(() {
                      _emailController.text.isEmpty?emailvalidate=true:emailvalidate=false;
                     });
                  }
                  else
                  {

                    authController.resetPassword(_emailController.text.trim());
                    Get.offAll(SignIn());
                  }
                  if((_emailController.text.isEmpty )){
                    setState(() {
                      _emailController.text.isEmpty?
                      emailvalidate=true:emailvalidate=false;
                   });
                  }
                },
                child: Text("Forgot your password".tr,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w900),)
            ),

          ),
        ],
      ),
    );
  }
}

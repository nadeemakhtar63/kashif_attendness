import 'package:automated_attendance_system/Widgets/EvelutedButton.dart';
import 'package:automated_attendance_system/Widgets/textfildfunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../Constant/AuthConstant.dart';
import '../Controller/authcontroller.dart';
import 'ForgetPassword.dart';
import 'SignIn.dart';
class CreateNewAccount extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);
  @override
  State<CreateNewAccount> createState() => _SignInState();
}
class _SignInState extends State<CreateNewAccount> {
  TextEditingController _nameController=new TextEditingController();
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  TextEditingController _cpasswordController=new TextEditingController();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool emailvalidate=false;
  bool namevalidate=false;
  bool cpvalidate=false;
  bool passwordvalidate=false;
  bool texthidecheck=true;
  @override
  void initState() {
    Get.put(AuthController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(height: 40,),
              Text("Create New Account".tr,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
              SizedBox(height: 20,),
              textField(
                emailEditingController:_nameController,
                emailvalidate:namevalidate,
                hintText: 'Name'.tr,
                textInputType: TextInputType.name,
                check:false,
              ),
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
              textField(
                emailEditingController:_cpasswordController,
                emailvalidate:cpvalidate,
                hintText: 'Confirm Password'.tr,
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
                      if((_passwordController.text!=_cpasswordController.text)||(_nameController.text.isEmpty )||(_emailController.text.isEmpty )||(_cpasswordController.text.isEmpty )||(_passwordController.text.isEmpty)){
                        setState(() {
                          _nameController.text.isEmpty?namevalidate=true:namevalidate=false;
                          _cpasswordController.text.isEmpty?_passwordController.text!=_cpasswordController.text?
                          cpvalidate=true:cpvalidate=false:cpvalidate=true;
                          _emailController.text.isEmpty?emailvalidate=true:emailvalidate=false;
                          _passwordController.text.isEmpty?passwordvalidate=true:passwordvalidate=false;
                        });
                      }

                      else if(pass_valid.hasMatch(_passwordController.text.trim())) {
                        authController.register(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _nameController.text.trim(),

                        );
                      }
                      else
                      {

                    Get.snackbar("Format not correct",'Please use of Capital Later,small Later,symbol and number in password ');
                      }
                    },
                    child: Text("Sign In".tr,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w900),)
                ),

              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?".tr,style: TextStyle(fontSize: 14,color: Colors.black),)
                  , InkWell(
                      onTap: (){
                        Get.to(SignIn());
                      },
                      child: Text("Sign in".tr,style: TextStyle(fontSize: 14,color: Colors.blueAccent),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

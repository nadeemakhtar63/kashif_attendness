import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Controller/authcontroller.dart';
import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Model_Classes/AddNewCourseModel.dart';
import 'package:automated_attendance_system/Widgets/CustomButton.dart';
import 'package:automated_attendance_system/Widgets/EvelutedButton.dart';
import 'package:automated_attendance_system/Widgets/textfildfunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddNewCourse extends StatefulWidget {
  const AddNewCourse({Key? key}) : super(key: key);

  @override
  State<AddNewCourse> createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  TextEditingController _CoursidController=new TextEditingController();
  TextEditingController _CourseNameController=new TextEditingController();
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
     appBar: AppBar(
       elevation: 0.0,
       backgroundColor: Colors.white,),
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height*0.4,
        width: MediaQuery.of(context).size.width*0.8,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12,width: 1),
          borderRadius: BorderRadius.circular(20)

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Add Course",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
            SizedBox(height: 20,),
            textField(
              emailEditingController:_CoursidController,
              emailvalidate:emailvalidate,
              hintText: 'Course Code'.tr,
              textInputType: TextInputType.text,
              check:false,
            ),
            textField(
              emailEditingController:_CourseNameController,
              emailvalidate:passwordvalidate,
              hintText: 'Course Name'.tr,
              textInputType: TextInputType.text,
              check:false,
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: 42,
              child: CustomButton(
                  // color: Color(0xC4C4C4),
                  onTap: (){
                    if((_CoursidController.text.isEmpty )||(_CourseNameController.text.isEmpty)){
                      setState(() {
                        _CoursidController.text.isEmpty?emailvalidate=true:emailvalidate=false;
                        _CourseNameController.text.isEmpty?passwordvalidate=true:passwordvalidate=false;
                      });
                    }
                    else{
                      AddNewCourseModelClass addcourse=new AddNewCourseModelClass(
                          courseId:_CoursidController.text,
                          courseName: _CourseNameController.text,
                          lectureTime: "2"
                      );
                      Firebase_Crud().addnewCourse(addcourse);
                      Navigator.pop(context);
                      // authController.login(_CoursidController.text,_passwordController.text,widget.signin==null?0:1);
                    }

                  },
                  text: "Add Course"
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

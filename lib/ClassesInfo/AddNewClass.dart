import 'package:automated_attendance_system/ClassesInfo/AddStudentsOneByOne.dart';
import 'package:automated_attendance_system/ClassesInfo/AddStudentsThroughExcelSheet.dart';
import 'package:automated_attendance_system/Home_Screen/Attance_Show.dart';
import 'package:automated_attendance_system/Home_Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddNewClass extends StatefulWidget {
  var course_id;
   AddNewClass({Key? key,required this.course_id}) : super(key: key);
  @override
  State<AddNewClass> createState() => _HomeState();
}

class _HomeState extends State<AddNewClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            Container(
              height:  MediaQuery.of(context).size.height*0.4,
              child: Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      // colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.5),BlendMode.dstATop),
                        image: AssetImage('assets/time-and-attendance.png',),fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap:(){
                          Get.to(AddStudentsOneByOne(classID:widget.course_id ,));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                            child: Container(
                              height:  MediaQuery.of(context).size.height*0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage
                                    (
                                      colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.1),BlendMode.dstATop),
                                      image: AssetImage('assets/about-us-hero-image-t.jpg',),fit: BoxFit.cover
                                  )
                              ),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Add Class",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),),
                                  SizedBox(height: 20,)
                                  ,Text("Add Student One by One",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: ()
                        {
                          Get.to(AddStudentsExcelSheet());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                            child: Container(
                              height:  MediaQuery.of(context).size.height*0.25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.1),BlendMode.dstATop),
                                      image: AssetImage('assets/excel_db.jpg',),fit: BoxFit.cover
                                  )
                              ),
                              child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Add Class",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),),
                                  SizedBox(height: 20,)
                                  ,Text("Add Student Through Excel Sheet",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300,),)
                                ],
                              ),
                              // child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Text("My Attendness\'s",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),)
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            // Container(
            //   height: MediaQuery.of(context).size.height*0.2,
            //   child: Card(
            //     elevation: 3,
            //     shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               colorFilter:new ColorFilter.mode(Colors.grey,BlendMode.dstATop),
            //               image: AssetImage('assets/winer_person.png',),fit: BoxFit.cover)
            //       ),
            //     ),
            //   ),
            //
            // )
          ],
        )
    );
  }
}

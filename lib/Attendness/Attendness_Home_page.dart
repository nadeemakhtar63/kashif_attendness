import 'package:automated_attendance_system/Attendness/Download_Attendness_Sheet.dart';
import 'package:automated_attendance_system/Attendness/Mark_Attendness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'View_Attendness.dart';

class AttendnessHomePage extends StatefulWidget {
  var courseKey;
   AttendnessHomePage({Key? key,this.courseKey}) : super(key: key);

  @override
  State<AttendnessHomePage> createState() => _AttendnessHomePageState();
}

class _AttendnessHomePageState extends State<AttendnessHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            decoration: BoxDecoration(
                color: Colors.indigo,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                     Get.to(()=>MarkAttendce(courseId: widget.courseKey,));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        width:MediaQuery.of(context).size.width*0.45,
                        child: Column(
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/atendness_mark.png',),
                                )),
                            Text("Mark Attendness",style: TextStyle(fontWeight: FontWeight.w700),),
                            SizedBox(height: 10,)
                          ],

                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(()=>ViewAttandness(courseID:widget.courseKey ,));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.3,
                        width:MediaQuery.of(context).size.width*0.45,
                        child: Column(
                          children: [
                            Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('assets/view_attandness.png',),
                                )),
                            Text("View Attendness",style: TextStyle(fontWeight: FontWeight.w700),),
                            SizedBox(height: 10,)
                          ],

                        ),
                      ),

                    ),
                  ),
                ],

              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  Get.to(DownLoadAttence(courseID: widget.courseKey));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    width:MediaQuery.of(context).size.width*0.45,
                    child: Column(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/download_attandnes.png',),
                            )),
                        Text("Download Attendness",style: TextStyle(fontWeight: FontWeight.w700),),
                        SizedBox(height: 10,)
                      ],

                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  width:MediaQuery.of(context).size.width*0.45,
                  child: Column(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/upload_attandness.png',),
                          )),
                      Text("Upload Attendness",style: TextStyle(fontWeight: FontWeight.w700),),
                      SizedBox(height: 10,)
                    ],

                  ),
                ),
              ),
            ],

          )
        ],
      ),
    );
  }
}

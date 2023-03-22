import 'package:automated_attendance_system/ClassesInfo/AddNewClass.dart';
import 'package:automated_attendance_system/Controller/AllCoursesFetchController.dart';
import 'package:automated_attendance_system/Courses/AddNewCourse.dart';
import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Model_Classes/AddNewCourseModel.dart';
import 'package:automated_attendance_system/Widgets/textfildfunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Courses/AddNewCourse.dart';
import 'package:automated_attendance_system/Model_Classes/AddNewCourseModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Widgets/CustomButton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _CoursidController=new TextEditingController();
  TextEditingController _CourseNameController=new TextEditingController();
  bool emailvalidate=false;
  bool passwordvalidate=false;
  bool texthidecheck=true;
  void initState() {
    Get.put(AllClassesFetchController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
          // Get.to(AddNewCourse());
            modelBottomSheet();
          }, label:Text("Add Course"),icon:Icon(Icons.add) ,),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.blueGrey,
        title: Text("Home Screen"),

        leading: IconButton(
          onPressed: (){
            
          },
          icon: Icon(Icons.person_rounded),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
    child: Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: firebaseFirestore.collection('course').doc(auth.currentUser!.uid).
                                collection('teacher').snapshots() ,
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> studentDataSnapshot)
                                {
                                  if (studentDataSnapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: const [
                                            Text('data loading...'),
                                            CircularProgressIndicator(),
                                          ],
                                        ));
                                  }
                                  else if (studentDataSnapshot.hasError) {
                                    // developer.log('Error: ${studentDataSnapshot.error}',
                                    // name: 'When loading student data');
                                    return const Text(
                                        'Error when loading student data');
                                  }
                                  else if (studentDataSnapshot.hasData) {
                                    return Container(
                                        child: ListView.builder(
                                        itemCount:studentDataSnapshot.data!.docs.length,
                                        itemBuilder:(context,item)
                                    {
                                      DocumentSnapshot doc = studentDataSnapshot.data!.docs[item];
                                      print('name is ....${doc['name']}');
                                      return Container(
                                        margin: EdgeInsets.all(20),
                                        child: InkWell(
                                          onTap: (){
                                            Get.to(AddNewClass(course_id: doc['course_id'],));
                                          },
                                          child: Card(
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(Icons.book),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('${doc['name']}',style: TextStyle(fontWeight: FontWeight.w900),),
                                                      Text(doc['course_id']),
                                                    ],
                                                  ),
                                                  Icon(Icons.forward, color: Colors.green,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  )
                                    );
                                    }
                                  else
                                    {
                                      return Text('data is EMpty');
                                    }
                                  }

                                  )
      )

    ),
      );
  }
modelBottomSheet() {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return
          DraggableScrollableSheet(
              initialChildSize: 0.75,
              //set this as you want
              maxChildSize: 0.75,
              //set this as you want
              minChildSize: 0.75,
              //set this as you want
              expand: true,
              builder: (context, scrollController) {
                return Container(

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))
                    ),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Add Course", style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),),
                            SizedBox(height: 20,),
                            textField(
                              emailEditingController: _CoursidController,
                              emailvalidate: emailvalidate,
                              hintText: 'Course Code'.tr,
                              textInputType: TextInputType.text,
                              check: false,
                            ),
                            textField(
                              emailEditingController: _CourseNameController,
                              emailvalidate: passwordvalidate,
                              hintText: 'Course Name'.tr,
                              textInputType: TextInputType.text,
                              check: false,
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.8,
                              height: 42,
                              child: CustomButton(
                                // color: Color(0xC4C4C4),
                                  onTap: () {
                                    if ((_CoursidController.text.isEmpty) ||
                                        (_CourseNameController.text.isEmpty)) {
                                      setState(() {
                                        _CoursidController.text.isEmpty ?
                                        emailvalidate = true : emailvalidate =
                                        false;
                                        _CourseNameController.text.isEmpty
                                            ?
                                        passwordvalidate = true
                                            : passwordvalidate =
                                        false;
                                      });
                                    }
                                    else {
                                      AddNewCourseModelClass addcourse = new AddNewCourseModelClass(
                                          courseId: _CoursidController.text,
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
                    )
                );
              }
          );
      }
  );
}
}

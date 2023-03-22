import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Widgets/CustomButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarkAttendce extends StatefulWidget {
  var courseId;
   MarkAttendce({Key? key,@required this.courseId}) : super(key: key);

  @override
  State<MarkAttendce> createState() => _MarkAttendceState();
}

class _MarkAttendceState extends State<MarkAttendce> {
  bool attendencebool=false;
  bool absentbool=false;
  String idofpresnt='';
  String idofabsent='';
  List prentList=[];
  List absentList=[];
  List attandnessMarkList=[];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime=DateFormat('kk:mm:ss').format(now);
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.2,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
            ),
            child: Center(child: Text(formattedDate),),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: firebaseFirestore.collection('admite_students').doc(widget.courseId).
                  collection('studentsinfo').snapshots() ,
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
                                print('name is ....${doc['studentname']}');
                                return Container(

                                  child: InkWell(
                                    onTap: (){
                                      // setState(() {
                                      //   if(idofshreduser!=doc.id)
                                      //   {
                                      //     setState(() {
                                      //       idofshreduser = doc.id;
                                      //       prentList.add(doc.id);
                                      //       attandnessMarkList.add(
                                      //           {
                                      //             'st_name':doc['studentname'],
                                      //             'roleno':doc['rollno'],
                                      //             'attendness':'present',
                                      //           }
                                      //       );
                                      //       attendencebool = !attendencebool;
                                      //     });
                                      //   }
                                      // });
                                      // Get.to(AddNewClass(course_id: doc['course_id'],));
                                    },
                                    child:Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      elevation: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            doc['url']!=null?CircleAvatar(
                                              backgroundImage: NetworkImage(doc['url']),
                                            ):CircleAvatar(backgroundColor: Colors.teal,),
                                            Column(
                                              children: [
                                                 Text('${doc['studentname']}',style: TextStyle(fontWeight: FontWeight.w900),),
                                                 Text(doc['rollno']),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap: (){
                                                      // postSharedList.add(doc.id);

                                                      // for(var a in postSharedList)
                                                      if(idofpresnt!=doc.id)
                                                      {
                                                        setState(()
                                                        {
                                                          idofpresnt = doc.id;
                                                          print('this is true');
                                                          prentList.add(doc.id);
                                                          Firebase_Crud.submitAttendness(
                                                              st_name: doc['studentname'],
                                                              roleno: doc['rollno'],
                                                              attendness: 'present',
                                                              times: formattedTime,
                                                              date: formattedDate,
                                                            courseid: widget.courseId
                                                          );
                                                          // if(idofshreduser!=doc.id) {

                                                          // isChecked = true;
                                                        });
                                                      }
                                                      else
                                                      {
                                                        setState(() {
                                                          print('this is false');
                                                          // isChecked =false;
                                                        });
                                                      }

                                                      // storeNewsComment(doc.id, message,postSharedList);
                                                      // print(postSharedList);
                                                    },
                                                    child:absentList.contains(doc.id)?Text(''):prentList.contains(doc.id)?
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Colors.blue
                                                        ),
                                                        child:Center(child:CircleAvatar(child: Text('P'),backgroundColor: Colors.purpleAccent,)
                                                        // Icon(
                                                        //   Icons.check,size: 24,)
                                                        )
                                                      // )
                                                      // :Center(child: Icon(Icons.add,size: 24,)),

                                                    )
                                                        :Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Colors.blue
                                                        ),
                                                        child:Center(child:idofpresnt==doc.id?
                                                        CircleAvatar(child: Text('P'),backgroundColor: Colors.red,)
                                                        :CircleAvatar(child: Text('P'),backgroundColor: Colors.teal,)
                                                          // Icon(
                                                        //   idofpresnt==doc.id?
                                                        //
                                                        //   Icons.check:Icons.add,size: 24,)
                                                        )
                                                      // )
                                                      // :Center(child: Icon(Icons.add,size: 24,)),

                                                    )


                                                ),
                                                SizedBox(width: 5,),
                                                InkWell(
                                                    onTap: (){
                                                      // postSharedList.add(doc.id);

                                                      // for(var a in postSharedList)
                                                      if(idofabsent!=doc.id)
                                                      {
                                                        setState(()
                                                        {
                                                          idofabsent = doc.id;
                                                          print('this is true');
                                                          absentList.add(doc.id);
                                                          Firebase_Crud.submitAttendness
                                                            (
                                                              st_name: doc['studentname'],
                                                              roleno: doc['rollno'],
                                                              attendness: 'Absent',
                                                              times: formattedTime,
                                                              date: formattedDate,
                                                              courseid: widget.courseId
                                                            );
                                                          // attandnessMarkList.add(
                                                          //   {
                                                          //     'st_name':doc['studentname'],
                                                          //     'roleno':doc['rollno'],
                                                          //     'attendness':'Absent',
                                                          //   }
                                                         // );
                                                          // if(idofshreduser!=doc.id) {

                                                          // isChecked = true;
                                                        });
                                                      }
                                                      else
                                                      {
                                                        setState(() {
                                                          print('this is false');
                                                          // isChecked =false;
                                                        });
                                                      }
                                                      // storeNewsComment(doc.id, message,postSharedList);
                                                      // print(postSharedList);
                                                    },
                                                    child:prentList.contains(doc.id)?Text(''): absentList.contains(doc.id)?
                                                    Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Colors.red
                                                        ),
                                                        child:Center(child: CircleAvatar(child: Text('A'),backgroundColor: Colors.red,))
                                                      // )
                                                      // :Center(child: Icon(Icons.add,size: 24,)),

                                                    )
                                                        :Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30),
                                                            color: Colors.red
                                                        ),
                                                        child:Center(
                                                        child:idofabsent==doc.id?
                                                        Icon(Icons.cancel,size: 24,):
                                                        CircleAvatar(child: Text('A'),backgroundColor: Colors.teal,))
                                                      // )
                                                      // :Center(child: Icon(Icons.add,size: 24,)),

                                                    )


                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
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
          ),
          // Container(
          //   height: MediaQuery.of(context).size.height*0.1,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1)]
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: CustomButton(
          //       onTap: (){
          //
          //       },
          //       text: "Submit",
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

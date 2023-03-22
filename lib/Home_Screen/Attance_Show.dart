import 'package:automated_attendance_system/Attendness/Attendness_Home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constant/AuthConstant.dart';

class Attandness extends StatefulWidget {
  const Attandness({Key? key}) : super(key: key);

  @override
  State<Attandness> createState() => _AttState();
}

class _AttState extends State<Attandness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
   Expanded(
    child: StreamBuilder<QuerySnapshot>(
    stream: firebaseFirestore.collection('course').doc(auth.currentUser!.uid).
    collection('teacher').snapshots() ,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> studentDataSnapshot)
    {
    if (studentDataSnapshot.connectionState == ConnectionState.waiting) {
    return Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
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
    else if (studentDataSnapshot.hasData)
    {
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
                    Get.to(AttendnessHomePage(courseKey: doc['course_id'],));
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
      ),
    );
    }
    else
    {
    return ListView.builder(
        itemCount:studentDataSnapshot.data!.docs.length,
        itemBuilder:(context,item)
        {
          DocumentSnapshot doc = studentDataSnapshot.data!.docs[item];
          return Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Icon(Icons.book),
                ListTile(
                  title:Text(doc['name']),
                  subtitle: Text(doc['course_id']),
                ),
                Icon(Icons.forward, color: Colors.green,),
              ],
            ),
          );
        }
    );
    }
    }

    )
    ),
        ],
      ),
    );
  }
}

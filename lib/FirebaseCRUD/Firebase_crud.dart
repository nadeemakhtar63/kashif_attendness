import 'dart:math';

import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Courses/AddNewCourse.dart';
import 'package:automated_attendance_system/Model_Classes/AddNewCourseModel.dart';
import 'package:automated_attendance_system/Model_Classes/student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  // final FirebaseAuth auth = FirebaseAuth.instance;

String schoolCollection = 'schools';
String studentCollection = 'students';
String teacherCollection = 'teachers';
class Firebase_Crud{



  static SaveStudentData(@required imageshare,@required String usernaem,@required String rollno,@required classid)async {
    try {
      var rng = new Random();
      String randomName = "";
      for (var i = 0; i < 20; i++) {
        print(rng.nextInt(100));
        randomName += rng.nextInt(100).toString();
      }
      final ref = FirebaseStorage.instance.ref(randomName);

      await ref.putFile(imageshare!);
      String url = await ref.getDownloadURL();
      final response=  firebaseFirestore
          .collection('admite_students')
          .doc(classid)
         .collection('studentsinfo')
          .add(
        {
          'rollno': rollno,
          'studentname': usernaem,
          'url': url,
        },
      ).then((value) => {
          Get.snackbar("Student Register","Student Register Successfully")
      });
      return response;
    }

    catch(error)
    {
      Get.snackbar("Student not Register","$error");
      print("error$error");
      return error;
    }
  }
  // add class or add new course
  addnewCourse(AddNewCourseModelClass newcourse)async{

    try{
      firebaseFirestore.collection("course").doc(auth.currentUser!.uid).collection("teacher")
          .add(newcourse.toMap()).then((value) => {
            Get.snackbar('Add','Course Add Sucessfully')
      });
    }
    catch(e){
    Get.snackbar('Add','Course Added Successfully');
    }
  }
  //retrive all classes or courses
  static Stream<List<AddNewCourseModelClass>> AllClassFetchFirebaseFuction() {
    // AddNewCourseModelClass newcourse=new AddNewCourseModelClass();
    return firebaseFirestore.collection('course').doc(auth.currentUser!.uid).
    collection('teacher').snapshots().map((QuerySnapshot query) {
      List<AddNewCourseModelClass> catagory = [];
      for (var todo in query.docs) {
        final catogorymodel = AddNewCourseModelClass.fromDocumentSnapshot(snapshot: todo);
        catagory.add(catogorymodel);
      }
      return catagory;
    });
  }

  static submitAttendness({@required st_name,@required roleno,@required attendness,@required date,required times,@required courseid}){
    try{
      firebaseFirestore.collection('atteness_submite').doc(courseid).collection('submitted')
          .add({
        'st_name':st_name,
        'roleno':roleno,
        'attendness':attendness,
        'datetime':date,
        'time':times

      });

    }
    catch(e)
    {
      Get.snackbar("Attandness not submited", '${e.toString()}');
    }
  }
}
Future<Map<String, dynamic>> deleteTeachers(
    {required String schoolName}) async {
  int teachersCount = await db
      .collection(schoolCollection)
      .doc(schoolName)
      .get()
      .then((value) => value.data()!['teachersCount']);
  return await db
      .collection(schoolCollection)
      .doc(schoolName)
      .collection(teacherCollection)
      .get()
      .then(
        (value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        await doc.reference.delete();
        teachersCount = teachersCount - 1;
        await db
            .collection(schoolCollection)
            .doc(schoolName)
            .update({'teachersCount': teachersCount});
      }
      return {'code': 200, 'result': 'Successfully deleted teachers'};
    },
  ).catchError((error) =>
  {'code': 400, 'result': 'Failed to delete teachers: $error'});
}
Future<Map<String, dynamic>> deleteStudents(
    {required String schoolName}) async {
  int studentsCount = await db
      .collection(schoolCollection)
      .doc(schoolName)
      .get()
      .then((value) => value.data()!['studentsCount']);
  return await db
      .collection(schoolCollection)
      .doc(schoolName)
      .collection(studentCollection)
      .get()
      .then(
        (value) async {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in value.docs) {
        await doc.reference.delete();
        studentsCount = studentsCount - 1;
        await db
            .collection(schoolCollection)
            .doc(schoolName)
            .update({'studentsCount': studentsCount});
      }
      return {'code': 200, 'result': 'Successfully deleted students'};
    },
  ).catchError((error) =>
  {'code': 400, 'result': 'Failed to delete students: $error'});
}
Future<List<Student>> getAllStudentsOfSchool(String schoolName) async {
  return await db
      .collection(schoolCollection)
      .doc(schoolName)
      .collection(studentCollection)
      .get()
      .then(
        (value) {
      List<Student> students = [];
      for (var doc in value.docs) {
        students.add(Student.fromMap(doc.data()));
      }
      return students;
    },
  );
}
Stream<QuerySnapshot<Map<String, dynamic>>> getAllSchools() {
  return db.collection(schoolCollection).snapshots();
}
Future<Map<String, dynamic>> addStudentData(Student student) async {
  // developer.log('adding student data');
  return await db
      .collection('admite_students')
      .doc('2')
      .collection('studentsinfo')
      .add(student.toMap())
      .then((_) => {
    'code': 200,
    'result': 'School added with ID: ${student.studentname}'
  })
      .catchError((error) => {
    'code': 400,
    'result': 'Failed to add school: $error',
  });
}
Future<Map<String, dynamic>> addSchoolDataSize(
    {required String schoolName,
      int? studentsCount,
      int? teachersCount}) async {
  // developer.log('adding school data size');
  return await db
      .collection(schoolCollection)
      .doc(schoolName)
      .set(
    studentsCount != null
        ? {
      'schoolName': schoolName,
      'studentsCount': studentsCount,
    }
        : {
      'schoolName': schoolName,
      'teachersCount': teachersCount,
    },
    SetOptions(merge: true),
  )
      .then((_) => {
    'code': 200,
    'result': 'School added with ID: $schoolName',
  })
      .catchError((error) => {
    'code': 400,
    'result': 'Failed to add School: $error',
  });
}
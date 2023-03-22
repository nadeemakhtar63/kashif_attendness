import 'package:automated_attendance_system/Controller/authcontroller.dart';
import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Model_Classes/student.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

Future<Map<String, dynamic>> excelToMap(
    Uint8List excelFile, String fileName) async {
  var excel = Excel.decodeBytes(excelFile);
  print('loading excel');
  bool isValidFormat = false;
  String schoolName = fileName;

  // List<String> excelFileNameSplit = excelFileName.split('-');
  // bool isStudent = excelFileName[1] == 'students'; // Teachers or Students

  //Name| Admission no.| Class| Father Name| Mother Name| Address| Blood group| Date of Birth| Contact No.1| Contact No.2| Department| Aadhar No.
  Set<String> headers =
  {
    'rollno',
    'studentname',
    'url',
    // 'AADHAR NO',
    // 'DISTRICT',
    // 'FATHER NAME',
    // 'PANCHAYAT',
    // 'PHONE',
    // 'MOTHER NAME',
    // 'idImageUrl',
    // 'photoUrl',
    // 'dateAdded'
    // 'ADMISSION NO',
  };

  // {
  //   'NAME',
  //   'ADMISSION NO',
  //   'CLASS',
  //   'FATHER NAME',
  //   'CONTACT NO 1',
  //   'MOTHER NAME',
  //   'CONTACT NO 2',
  //   'ADDRESS',
  //   'BLOOD GROUP',
  //   'DATE OF BIRTH',
  //   'DEPARTMENT',
  //   'DESIGNATION',
  //   'AADHAR NO',
  // };
  Map<String, dynamic> result = {};
  try {
    var table = excel.tables.keys.first;
    Set<String> tempHeaders = {};

    if (table.isNotEmpty) {
      int num = 0;
      for (var row in excel.tables[table]!.rows) {
        num++;
        // Check if the headers are correct
        if (num == 1) {
          print('checking format');
          for (int i = 0; i < row.length; i++) {
            tempHeaders.add(row[i]!.value.toString().trim());
          }
          print('validating format');
          // get the intersections of two sets
          // if number of intersections match the length of tempHeaders
          // its valid
          if (headers.intersection(tempHeaders).length == tempHeaders.length) {
            isValidFormat = true;
            print('format is valid');
            continue;
          } else {
            isValidFormat = false;
            print('format is invalid');
            result = {
              'code': 400,
              'result':
              'Format is invalid. Please check the excel file again. $tempHeaders'
            };
            return result;
          }
        }
        // If the headers are correct, start loading the data
        if (isValidFormat) {
          print('adding school data');
          int currentIndex = num - 1;
          Map<String, dynamic> rowMap = {};
          bool isStudent = false;

          // print(row.length);
          for (int i = 0; i < row.length; i++) {
            rowMap['rollno'] = schoolName;
            rowMap[tempHeaders.toList()[i]] = row[i]!.value.toString();
            print(rowMap);
          }
          // if (rowMap['AADHAR NO'] != null) {
          //   print('adding teacher');
          //   isStudent = false;
          //   await addTeacherData(
          //     Teacher.fromMap(rowMap),
          //   );
          //   await addSchoolDataSize(
          //       schoolName: schoolName, teachersCount: currentIndex);
          // }
          if (rowMap['rollno'] != null) {
            print('adding student');
            isStudent = true;
            // print(rowMap);
            await addStudentData(
              Student.fromMap(rowMap),
            );
            await addSchoolDataSize(
                schoolName: schoolName, studentsCount: currentIndex);
          }
        }
      }
    }

    result = {'code': 200, 'result': 'File added successfully'};
    return result;
  } catch (e) {
    print('error adding school data');
    print(e.toString());
    result = {'code': 400, 'result': 'Failed to add the file: $e'};
    return result;
  }
}
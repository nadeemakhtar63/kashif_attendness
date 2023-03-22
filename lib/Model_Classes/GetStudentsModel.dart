import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetStudentsModel {
  String? name;
  String? roll_no;
  String? image;
  GetStudentsModel({required this.name,required this.roll_no,required this.image});
  Map<String,dynamic> toMap(){
    return{
      'rollno': roll_no,
      'studentname': name,
      'url': image,
    };
  }
  GetStudentsModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot})
  {
   name=documentSnapshot['studentname'];
   roll_no=documentSnapshot['rollno'];
   image=documentSnapshot['url'];
  }
}

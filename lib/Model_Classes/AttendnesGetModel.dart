import 'package:cloud_firestore/cloud_firestore.dart';

class AttendnessGetModel{
  String? attendness;
  String? datetime;
  String? roleno;
  String? st_name;
  String? times;
  AttendnessGetModel({required this.st_name,required this.roleno,required this.attendness, required this.datetime,required this.times});
  Map<String,dynamic>toMap() {
    return {
      'st_name':st_name,
      'roleno':roleno,
      'attendness':attendness,
      'datetime':datetime,
      'time':times
    };
  }
  AttendnessGetModel.fromDocumentSnapshot({required DocumentSnapshot snapshot})
  {
    st_name=snapshot['st_name'];
    datetime=snapshot['datetime'];
    roleno=snapshot['roleno'];
    attendness=snapshot['attendness'];
    times=snapshot['time'];
  }
}
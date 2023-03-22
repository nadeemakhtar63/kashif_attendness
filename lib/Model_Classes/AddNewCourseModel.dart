import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewCourseModelClass{
 late String course_doc_ID;
 late String courseId;
 late String courseName;
 late String lectureTime;

 AddNewCourseModelClass({required this.courseId,required this.courseName,required this.lectureTime});
 Map<String,dynamic> toMap(){
return{
 'course_id':courseId,
 'name':courseName,
 'lecture_time':lectureTime
};
 }
 AddNewCourseModelClass.fromDocumentSnapshot({required DocumentSnapshot snapshot})
{
 course_doc_ID=snapshot.id;
 courseId=snapshot['course_id'];
 courseName=snapshot['name'];
 lectureTime=snapshot['lecture_time'];
}
}
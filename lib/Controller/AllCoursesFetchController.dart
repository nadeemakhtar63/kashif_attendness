import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Model_Classes/AddNewCourseModel.dart';
import 'package:get/get.dart';
class AllClassesFetchController extends GetxController{
  Rx<List<AddNewCourseModelClass>> allClassesList=Rx<List<AddNewCourseModelClass>>([]);

  List<AddNewCourseModelClass> get allClassfetchinggeter=>allClassesList.value;
  @override
  void OnReady(){
  allClassesList.bindStream(Firebase_Crud.AllClassFetchFirebaseFuction());
  }
}
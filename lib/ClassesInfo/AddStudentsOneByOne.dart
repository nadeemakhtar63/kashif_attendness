import 'dart:io';

import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:automated_attendance_system/Widgets/CustomButton.dart';
import 'package:automated_attendance_system/Widgets/textfildfunction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentsOneByOne extends StatefulWidget {
  var classID;
   AddStudentsOneByOne({Key? key,@required this.classID}) : super(key: key);

  @override
  State<AddStudentsOneByOne> createState() => _AddStudentsOneByOneState();
}

class _AddStudentsOneByOneState extends State<AddStudentsOneByOne> {
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  /// Get from camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  File? imageFile;
  showAlertDialog(BuildContext context) {
    Widget okButton = MaterialButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Media"),
      actions: [
        IconButton(onPressed: (){
          _getFromCamera();
          Navigator.pop(context);
        }, icon: Icon(Icons.camera_alt)),
        IconButton(onPressed: (){
          _getFromGallery();
          Navigator.pop(context);
        }, icon: Icon(Icons.description))

      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  TextEditingController nameController=new TextEditingController();
  TextEditingController rollnoController=new TextEditingController();
  bool namecheck=false;
  bool roleNo=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    body: Column(
      children: [
      Container(
        height: MediaQuery.of(context).size.height*0.2,
        width: double.infinity,
        child: InkWell(
          onTap: (){

          },
          child: Card(
            elevation: 0.0,
            child: Container(
              height: 90,
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Add Through Face Detection'),
                  SizedBox(height: 10,),
                  Card(
                      elevation: 10,
                      child: Image.asset('assets/face-id.png',height: 90,width: 90,)),
                ],
              ),
            ),
          ),
        ),
      ),
        Text("OR"),
        // Divider(),
        Expanded(

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      imageFile==null?
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.teal,
                          // image: DecorationImage(image: NetworkImage(doc['url']),fit: BoxFit.cover)
                        ),
                        child: Icon(Icons.person),
                      ):
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.teal,
                            image: DecorationImage(image: FileImage(imageFile!),fit: BoxFit.cover)
                        ),
                        //child:  Image.file(imageFile!,fit: BoxFit.cover,),
                      ),
                      //        :Container(
                      //   height: 120,
                      //   width: 120,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(90),
                      //     color: Colors.teal,
                      //     image: DecorationImage(image: NetworkImage(doc['url']),fit: BoxFit.cover)
                      //   ),
                      //  //child:  Image.file(imageFile!,fit: BoxFit.cover,),
                      // ),
                      Positioned(
                          bottom: 10,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3.0, // soften the shadow
                                    spreadRadius: 3.0, //extend the shadow
                                    // offset: Offset(
                                    //   15.0, // Move to right 10  horizontally
                                    //   15.0, // Move to bottom 10 Vertically
                                    // ),
                                  )// Move to bottom 10 Vertically
                                ],
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: IconButton(
                                onPressed: (){
                                  showAlertDialog(context);
                                },
                                icon: Icon(Icons.add)),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                textField(
                    hintText: "Student Name",
                    emailEditingController: nameController,
                    emailvalidate:namecheck,
                    check: false
                ),
                SizedBox(height: 10,),
               textField(
                 hintText: "Roll No",
                 emailEditingController: rollnoController,
                   emailvalidate:roleNo,
                   check: false),
                SizedBox(height: 10,),
                CustomButton(
                  onTap: ()
                  {
                if(nameController.text.isEmpty && rollnoController.text.isEmpty)
                  {
                  setState(() {
                  nameController.text.isEmpty? namecheck=true:namecheck=false;
                  rollnoController.text.isEmpty?roleNo=true:roleNo=false;
                  });
                  }
                else if(imageFile==null)
                {
                  Get.snackbar('Student Image Required','Please Add student Image');
                }
                else
                      {
                      Firebase_Crud.SaveStudentData(
                          imageFile,
                          nameController.text.toString(),
                          rollnoController.text.toString(),
                        widget.classID
                      );
                      setState(() {
                        nameController.clear();
                        rollnoController.clear();
                        imageFile=null;
                      });

                    }
                  },
                  text: "Student Admitted",
                )
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }
}

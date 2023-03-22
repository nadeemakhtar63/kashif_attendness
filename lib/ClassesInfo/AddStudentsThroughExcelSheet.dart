import 'dart:convert';
import 'dart:io';
import 'package:automated_attendance_system/ClassesInfo/file_upload_table.dart';
import 'package:automated_attendance_system/ClassesInfo/header.dart';
import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddStudentsExcelSheet extends StatefulWidget {
  const AddStudentsExcelSheet({Key? key}) : super(key: key);
  @override
  State<AddStudentsExcelSheet> createState() => _AddStudentsExcelSheetState();
}

class _AddStudentsExcelSheetState extends State<AddStudentsExcelSheet> {
  List <List<dynamic>> _data=[];
  String? filepath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Column(
            children: [
            const Header(
            title: 'File Uploads',
          ),
IconButton(
          onPressed: () async {
            FilePickerResult? filePickerResult =
            await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: [
                'xlsx',
              ],
            );
            print('filePickerResult');

            if (filePickerResult != null) {
              if (!mounted) return;
              Uint8List? fileBytes = filePickerResult.files.first.bytes;
              String fileName = filePickerResult.files.first.name;
              fileName = fileName.replaceAll('.xlsx', '');
              try {
                excelToMap(fileBytes!, fileName).then((result) {
                  print('excel to map');
                  if (result['code'] == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: AwesomeSnackbarContent(
                          title: 'File uploaded!',
                          message: result['result'],
                          contentType: ContentType.success),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: AwesomeSnackbarContent(
                          title: 'Error',
                          message: result['result'],
                          contentType: ContentType.failure),
                    ));
                  }
                });
              } catch (e) {
                print(e.toString());
              }
            }
          },
          icon: const Icon(Icons.add),
          // label: const Text("Add New Excel File"),
      ),
      const SizedBox(height: 16),
      const FileUploadTable(
          // height: MediaQuery.of(context).size.height * 0.7,
      ),
      ],
    ),
        )
      )
    );
  }
  // void _pickFile()async {
  //   final result=await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if(result==null) return;
  //   print(result.files.first.name);
  //   filepath=result.files.first.path;
  //   final input=File(filepath!).openRead();
  //   final fields=await input
  //       .transform(utf8.decoder)
  //       .transform(const CsvToListConverter())
  //       .toList();
  //   print(fields);
  //   setState((){
  //   _data=fields;
  //   });
  // }
}



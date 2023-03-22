import 'package:automated_attendance_system/FirebaseCRUD/Firebase_crud.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class FileUploadTable extends StatefulWidget {
  const FileUploadTable({Key? key}) : super(key: key);
  @override
  State<FileUploadTable> createState() => _FileUploadTableState();
}
class _FileUploadTableState extends State<FileUploadTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 236, 236, 236),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Excel Files",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            height: 500,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getAllSchools(),
              builder: (context, schoolsSnapshot) {
                if (schoolsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (schoolsSnapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(

                      // columnSpacing: 16,
                      // minWidth: 600,
                      dataRowHeight: 50,
                      columns: const [
                        DataColumn(
                          label: Text("File Name"),
                        ),
                        DataColumn(
                          label: Text("Student Rows"),
                        ),
                        DataColumn(
                          label: Text("Teacher Rows"),
                        ),
                        DataColumn(
                          label: Text("Settings"),
                        ),
                      ],
                      rows: List.generate(
                        schoolsSnapshot.data!.size,
                        (index) {
                          return fileUploadDataRow(
                            schoolName: schoolsSnapshot.data!.docs[index]
                                .data()['schoolName'],
                            studentsCount: schoolsSnapshot.data!.docs[index]
                                .data()['studentsCount']
                                .toString(),
                            teachersCount: schoolsSnapshot.data!.docs[index]
                                .data()['teachersCount']
                                .toString(),
                            context: context,
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No school data files'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow fileUploadDataRow({
  required String schoolName,
  required String? studentsCount,
  required String? teachersCount,
  required BuildContext context,
}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/excle_file.svg',
              height: 30,
              width: 30,
            ),
        ]
      )
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectableText(
            studentsCount! == 'null' ? '0' : studentsCount,
            showCursor: true,
            textHeightBehavior: const TextHeightBehavior(),
          ),
        ),
      ),
      DataCell(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SelectableText(
            teachersCount! == 'null' ? '0' : teachersCount,
            showCursor: true,
            textHeightBehavior: const TextHeightBehavior(),
          ),
        ),
      ),
      DataCell(
        TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Delete school data'),
                    content: Text(
                        'Are you sure you want to delete $schoolName data?'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () async {
                          Navigator.pop(dialogContext);
                          var snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content:Text('Deleting school'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Map<String, dynamic> result =
                              await deleteTeachers(schoolName: schoolName);

                          snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackbarContent(
                              title: result['code'] == 200
                                  ? 'Successfully deleted'
                                  : 'Error',
                              message: result['result'],
                              contentType: result['code'] == 200
                                  ? ContentType.success
                                  : ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Delete school'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () async {
                          Navigator.pop(dialogContext);

                          var snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackbarContent(
                                title: 'Deleting students',
                                message: '',
                                contentType: ContentType.help),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Map<String, dynamic> result =
                              await deleteStudents(schoolName: schoolName);

                          snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackbarContent(
                              title: result['code'] == 200
                                  ? 'Successfully deleted'
                                  : 'Error',
                              message: result['result'],
                              contentType: result['code'] == 200
                                  ? ContentType.success
                                  : ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Delete Students'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(dialogContext);

                          var snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackbarContent(
                                title: 'Deleting teachers',
                                message: '',
                                contentType: ContentType.help),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          Map<String, dynamic> result =
                              await deleteTeachers(schoolName: schoolName);

                          snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackbarContent(
                              title: result['code'] == 200
                                  ? 'Successfully deleted'
                                  : 'Error',
                              message: result['result'],
                              contentType: result['code'] == 200
                                  ? ContentType.success
                                  : ContentType.failure,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        child: const Text('Delete teachers'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                });
          },
          child: const Text(
            'delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    ],
  );
}

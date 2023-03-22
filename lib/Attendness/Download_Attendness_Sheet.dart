import 'dart:io';

import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Model_Classes/AttendnesGetModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
class DownLoadAttence extends StatefulWidget {
  var courseID;
   DownLoadAttence({Key? key,required this.courseID}) : super(key: key);
  @override
  State<DownLoadAttence> createState() => _DownLoadAttenceState();
}

class _DownLoadAttenceState extends State<DownLoadAttence> {
  List<List<String>> itemList = [];

  // Stream<QuerySnapshot> streamQuery=firebaseFirestore.collection('atteness_submite')
  //     .doc(widget.courseID).collection('submitted').snapshots();
  @override
  void initState() {
    // TODO: implement initState

    itemList =
    [<String>['st_name', 'roleno', 'attendness', 'datetime', 'time']];
  }
  late String filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    filePath = '$path/data.csv';
    return File('$path/data.csv').create();
  }
  TextEditingController startDate=new TextEditingController();
  TextEditingController endDate=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                getCsv();
              },
              icon:Icon(Icons.download))
        ],
        title: Text('Attence Sheet'),centerTitle: true,),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width*0.45,
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter Start Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    controller: startDate,
                    readOnly: true,
                    validator: (startDate){
                      if(startDate==null|| startDate.isEmpty){
                        return "Please Input Start Date";
                      }else return null;
                    },
                    onTap: () async{
                      DateTime? startPickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:DateTime(2000),
                          lastDate: DateTime(2100)
                      );
                      if(startPickedDate!= null){
                        String formattedDate = DateFormat('dd-MM-yyyy').format(startPickedDate);
                        setState(() {
                          startDate.text = formattedDate; //set output date to TextField value.
                        });
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width*0.45,
                child: Center(
                  child: TextFormField(
                    controller: endDate,
                    readOnly: true,
                    decoration: InputDecoration(
                        fillColor: Colors.teal,
                        hintText: "End Date",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    validator: (endDate){
                      if(endDate==null || endDate.isEmpty){
                        return "Please Input End Date";
                      }else {
                        return null;
                      }
                    },
                    onTap: () async{
                      if (startDate.text.isNotEmpty) {
                        String dateTime = startDate.text;
                        DateFormat inputFormat = DateFormat('dd-MM-yyyy');
                        DateTime input = inputFormat.parse(dateTime);

                        DateTime? endPickedDate = await showDatePicker(
                          context: context,
                          initialDate: input.add(const Duration(days: 1)),
                          firstDate:  input.add(const Duration(days: 1)),
                          lastDate: DateTime(2100),
                        );
                        if(endPickedDate!= null){
                          String formattedDate = DateFormat('dd-MM-yyyy').format(endPickedDate);
                          setState(() {
                            endDate.text = formattedDate;
                          }
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You need to select Start Date')));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore.collection('atteness_submite')
                .doc(widget.courseID).collection('submitted').where('datetime',isGreaterThanOrEqualTo: startDate.text.toString())
                .where('datetime',isLessThanOrEqualTo: endDate.text.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    border: const TableBorder(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                      left: BorderSide(color: Colors.grey, width: 0.5),
                      right: BorderSide(color: Colors.grey, width: 0.5),
                      horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
                      verticalInside: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('RollNo')),
                      DataColumn(label: Text('Attendance')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Time')),
                    ],
                    rows: _buildList(context, snapshot.data!.docs)
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return  snapshot.map((data) => _buildListItem(context, data)).toList();
  }
  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = AttendnessGetModel.fromDocumentSnapshot(snapshot: data);

    return DataRow(cells: [
      DataCell(Text(record.st_name.toString())),
      DataCell(Text(record.roleno.toString())),
      DataCell(Text(record.attendness.toString())),
      DataCell(Text(record.datetime.toString())),
      DataCell(Text(record.times.toString())),
    ]);
  }

  genrateCSV()async{
    String csv=ListToCsvConverter().convert(itemList);
    DateTime dtimeknoow=DateTime.now();
    String formatDate=DateFormat('MM-dd-yyyy-HH-mm-ss').format(dtimeknoow);

    Directory gernalDownloadDirectory=Directory('storage/emulated.0/Download');
    final File file=await (File('${gernalDownloadDirectory.path}/item_export_$formatDate.csv').create());
    await file.writeAsString(csv);
  }

  getCsv() async {

    List<List<dynamic>> rows = <List<dynamic>>[];

    var cloud = await firebaseFirestore.collection('atteness_submite')
        .doc(widget.courseID).collection('submitted')
        .get();

    rows.add([
      "Name",
      "roleno",
      "attendness",
      "datetime",
      "time",
    ]);

    if (cloud.docs != null) {
      List<dynamic> row = <dynamic>[];
      cloud.docs.forEach((element) {
        row.add(element['st_name']);
        row.add(element['roleno']);
        row.add(element['attendness']);
        row.add(element['datetime']);
        row.add(element['time']);
        rows.add(row);
      });
      // for (int i = 0; i < cloud.docs.length; i++) {
      //   List<dynamic> row = <dynamic>[];
      //   row.add(cloud.docs["collected"][i]["name"]);
      //   row.add(cloud.data["collected"][i]["gender"]);
      //   row.add(cloud.data["collected"][i]["phone"]);
      //   row.add(cloud.data["collected"][i]["email"]);
      //   row.add(cloud.data["collected"][i]["age_bracket"]);
      //   row.add(cloud.data["collected"][i]["area"]);
      //   row.add(cloud.data["collected"][i]["assembly"]);
      //   row.add(cloud.data["collected"][i]["meal_ticket"]);
      //   rows.add(row);
      // }
      File f = await _localFile;

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    }
  }
}
import 'package:automated_attendance_system/Attendness/Attendness_Home_page.dart';
import 'package:automated_attendance_system/Constant/AuthConstant.dart';
import 'package:automated_attendance_system/Model_Classes/AttendnesGetModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewAttandness extends StatefulWidget {
  var courseID;
   ViewAttandness({Key? key,required this.courseID}) : super(key: key);

  @override
  State<ViewAttandness> createState() => _ViewAttandnessState();
}

class _ViewAttandnessState extends State<ViewAttandness> {
  TextEditingController startDate=new TextEditingController();
  TextEditingController endDate=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attence Sheet'),centerTitle: true,),
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
}

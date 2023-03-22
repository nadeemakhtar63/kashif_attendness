import 'package:automated_attendance_system/Home_Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Attance_Show.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.transparent,
        elevation: 0.0,
        foregroundColor: Colors.grey,
        centerTitle: true,
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notification_add))
        ],
      ),
      drawer: Drawer(
       child: ListView(
        // Important: Remove any paddin g from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('AUTOMATED ATTENDNESS',
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color: Colors.white),)),
          ),
          ListTile(
            title: Row(
              children:[
                Icon(Icons.settings),
                Expanded(child: Container(),),
                Text("Settings")
              ]
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            title: Row(
                children:[
                  Icon(Icons.add_task),
                  SizedBox(width: 20,),
                  Text("Attendness")
                ]
            ),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(
            title: Row(
                children:[
                  Icon(Icons.markunread_mailbox),
                  SizedBox(width: 20,),
                  Text("Courses")
                ]
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Divider(),
          ListTile(
            title: Row(
                children:[
                  Icon(Icons.person_outline_rounded),
                  SizedBox(width: 20,),
                  Text("Profile")
                ]
            ),
            onTap: () {

            },
          ),
          Divider(),
        ],
      ),
      ),
      body:Column(
        children: [
          Container(
            height:  MediaQuery.of(context).size.height*0.2,
            child: Container(
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      // colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.5),BlendMode.dstATop),
                      image: AssetImage('assets/time-and-attendance.png',),fit: BoxFit.cover
                  )
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
               children: [
                 InkWell(
                   onTap:(){
                     Get.to(Attandness());
                   },
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Card(
                       elevation: 3,
                       shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                       child: Container(
                         height:  MediaQuery.of(context).size.height*0.2,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             image: DecorationImage
                               (
                                 colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.3),BlendMode.dstATop),
                                 image: AssetImage('assets/about-us-hero-image-t.jpg',),fit: BoxFit.cover
                              )
                         ),
                         child:
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text("Attandance",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),)
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
                 InkWell(
                 onTap: ()
                   {
                     Get.to(HomeScreen());
                   },
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Card(
                       elevation: 3,
                       shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                       child: Container(
                         height:  MediaQuery.of(context).size.height*0.2,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             image: DecorationImage(
                                 colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.5),BlendMode.dstATop),
                                 image: AssetImage('assets/courses.png',),fit: BoxFit.cover
                             )
                         ),
                         // child: Row(
                         //   mainAxisAlignment: MainAxisAlignment.center,
                         //   crossAxisAlignment: CrossAxisAlignment.center,
                         //   children: [
                         //     Text("My Attendness\'s",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),)
                         //   ],
                         // ),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Card(
                     elevation: 3,
                     shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                     child: Container(
                       height:  MediaQuery.of(context).size.height*0.2,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           image: DecorationImage(
                               colorFilter:new ColorFilter.mode(Colors.grey.withOpacity(0.5),BlendMode.dstATop),
                               image: AssetImage('assets/Teacher-in-the-classroom.jpg',),fit: BoxFit.cover
                           )
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [

                           Text("My Attendness\'s",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),)

                         ],
                       ),
                     ),
                   ),
                 ),
               ],
                ),
              ),
            ),
          )
          // Container(
          //   height: MediaQuery.of(context).size.height*0.2,
          //   child: Card(
          //     elevation: 3,
          //     shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
          //     child: Container(
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //               colorFilter:new ColorFilter.mode(Colors.grey,BlendMode.dstATop),
          //               image: AssetImage('assets/winer_person.png',),fit: BoxFit.cover)
          //       ),
          //     ),
          //   ),
          //
          // )
        ],
      )
    );
  }
}

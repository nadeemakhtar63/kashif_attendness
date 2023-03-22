class Student {
 //  String name;
 //  // String schoolName;
 //  // String admissionNum;
 //  // String? className;
 //  // String fatherName;
 //  // String contactNum1;
 //  // String motherName;
 //  // String? contactNum2;
 //  // String address;
 //  // String? bloodGroup;
 //  // String dob;
 //  // String? idImageUrl;
 //  // String? photoUrl;
 //  // String? dateAdded;
 //  // Student({
 //  //   required this.name,
 //  //   required this.schoolName,
 //  //   required this.admissionNum,
 //  //   this.className,
 //  //   required this.fatherName,
 //  //   required this.contactNum1,
 //  //   required this.motherName,
 //  //   this.contactNum2,
 //  //   required this.address,
 //  //   this.bloodGroup,
 //  //   required this.dob,
 //  //   this.idImageUrl,
 //  //   this.photoUrl,
 //  //   this.dateAdded,
 //  // });
 // String? phone;
 // String? panchat;
 // String? fathername;
 // String? district;
 // String? aadhar;
 // String? registration;
 // String motherName;
 // String? mandal;
 // String dateAdded;
 // String idImageUrl;
 // String photoUrl;
 // String address;
 String rollno;
 String studentname;
 String url;
 Student(
     {
   required this.rollno,
       required this.url,
       required this.studentname
       // required this.name,
       // // required this.schoolName,
       // // required this.admissionNum,
       // required this.idImageUrl,
       // required this.phone,
       // required this.panchat,
       // required this.fathername,
       // required this.district,
       // required this.aadhar,
       // // required this.address,
       // required this.registration,
       // required this.motherName,
       // required this.dateAdded,
       // required this.photoUrl,
       // required this.mandal
     });
  Map<String, dynamic> toMap() {
    return {
      'rollno':rollno,
      'url':url,
      'studentname':studentname,
      // 'DISTRICT':district,
      // 'AADHAR NO.':aadhar,
      // 'REGISTRATION NO':registration,
      // 'MANDAL':mandal,
      // // 'SCHOOL NAME': schoolName,
      // 'NAME': name,
      // // 'ADMISSION NO': admissionNum,
      // // 'CLASS': className,
      // // 'DATE OF BIRTH': dob,
      // // 'BLOOD GROUP': bloodGroup,
      // 'MOTHER NAME': motherName,
      // // 'ADDRESS': address,
      // // 'CONTACT NO 1': contactNum1,
      // // 'CONTACT NO 2': contactNum2,
      // 'idImageUrl': idImageUrl,
      // 'photoUrl': photoUrl,
      // 'dateAdded': dateAdded,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
   return Student(
     rollno: map['rollno'] ?? '',
     url: map['url'] ?? '',
     studentname: map['studentname'] ?? '',
       // phone: map['PHONE'] ?? '',
       // panchat: map['PANCHAYAT'] ?? '',
       // fathername: map['FATHER NAME'] ?? '',
       // // schoolName: map['SCHOOL NAME'] ?? '',
       // // admissionNum: map['ADMISSION NO'] ?? '',
       // district: map['DISTRICT'] ?? '',
       //  // address: map['ADDRESS'] ?? '',
       // aadhar: map['AADHAR NO'] ?? '',
       // registration: map['REGISTRATION NO'] ?? '',
       // mandal: map['MANDAL']??'',
       // motherName: map['MOTHER NAME'] ?? '',
       //  name: map['NAME'] ?? '',
   );
    // return Student(
    //   name: map['NAME'] ?? '',
    //   schoolName: map['SCHOOL NAME'] ?? '',
    //   admissionNum: map['ADMISSION NO'] ?? '',
    //   className: map['CLASS'],
    //   fatherName: map['FATHER NAME'] ?? '',
    //   contactNum1: map['CONTACT NO 1'] ?? '',
    //   motherName: map['MOTHER NAME'] ?? '',
    //   contactNum2: map['CONTACT NO 2'] ?? '',
    //   address: map['ADDRESS'] ?? '',
    //   bloodGroup: map['BLOOD GROUP'] ?? '',
    //   dob: map['DATE OF BIRTH'] ?? '',
    //   idImageUrl: map['idImageUrl'] ?? '',
    //   photoUrl: map['photoUrl'] ?? '',
    //   dateAdded: map['dateAdded'] ?? '',
    // );
  }
}

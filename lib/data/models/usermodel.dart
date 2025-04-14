// ignore_for_file: public_member_api_docs, sort_constructors_first
// class UserModel {
//   late final String id;
//   late final String email;
//   late final String fastName;
//   late final String lastName;
//   late final String mobile;
//   late final String createdDate;

//   UserModel.convatedJsonToDart(Map<String, dynamic> datajson) {
//     id = datajson["_id"];
//     email = datajson["email"];
//     fastName = datajson["fastName"];
//     lastName = datajson["lastName"];
//     mobile = datajson["mobile"];
//     createdDate = datajson["createdDate"];
//   }
// // }

// class UserModel {
//   late final String id;
//   late final String email;
//   late final String fastName;
//   late final String lastName;
//   late final String mobile;
//   late final String createdDate;

//   UserModel.fromJson(Map<String, dynamic> datajson) {
//     id = datajson["_id"] ?? "";
//     email = datajson["email"] ?? "";
//     fastName = datajson["fastName"] ?? "";
//     lastName = datajson["lastName"] ?? "";
//     mobile = datajson["mobile"];
//     createdDate = datajson["createdDate"] ?? "";
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "_id": id,
//       "email": email,
//       "fastName": fastName,
//       "lastName": lastName,
//       "mobile": mobile,
//       "createdDate": createdDate
//     };
//   }

//   String get fulName {
//     return '$fastName  $lastName';
//   }
// }

class UserModel {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;
  late final String photo;

  // named constructor
  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'] ?? '';
    email = jsonData['email'] ?? '';
    firstName = jsonData['firstName'] ?? '';
    lastName = jsonData['lastName'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    createdDate = jsonData['createdDate'] ?? '';
    photo = jsonData['photo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }

  String get fulName {
    return '$firstName $lastName';
  }
}
// class UserModel {
//   final String id;
//   final String email;
//   final String fastName;
//   final String lastName;
//   final String mobile;
//   final String createdDate;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fastName,
//     required this.lastName,
//     required this.mobile,
//     required this.createdDate,
//   });

//   factory UserModel.convatedJsonToDart(Map<String, dynamic> datajson) {
//     return UserModel(
//         id: datajson["_id"] ?? "",
//         email: datajson["email"] ?? "",
//         fastName: datajson["fastName"] ?? "",
//         lastName: datajson["lastName"] ?? "",
//         mobile: datajson["mobile"] ?? "",
//         createdDate: datajson["createdDate"] ?? "");
//   }
// }

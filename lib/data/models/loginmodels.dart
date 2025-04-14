import 'package:taskmenager_app/data/models/usermodel.dart';

class LoginModels {
  late final String token;
  late final String status;
  late final UserModel userModel;

  LoginModels.fromJson(Map<String, dynamic> dataJson) {
    token = dataJson["token"] ?? "";
    status = dataJson["status"] ?? "";
    userModel = UserModel.fromJson(dataJson["data"] ?? {});
  }
}

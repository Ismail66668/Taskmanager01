class TaskModel {
  late final String id;
  late final String titel;
  late final String discription;
  late final String status;
  late final String createDate;
  TaskModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData["_id"];
    titel = jsonData["titel"] ?? "";
    discription = jsonData["discription"] ?? "";
    status = jsonData["status"] ?? "";
    createDate = jsonData["createDate"] ?? "";
  }
}

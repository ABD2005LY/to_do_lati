import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String title;
  String? subTitle;
  bool isCompleted;
  DateTime createdAt;

  TaskModel({
    required this.title,
    this.subTitle,
    this.isCompleted = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subTitle,
      // ignore: equal_keys_in_map
      'subtitle': subTitle,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      subTitle: json['subTitle'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

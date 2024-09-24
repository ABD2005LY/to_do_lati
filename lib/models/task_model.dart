<<<<<<< HEAD
import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

=======
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
class TaskModel {
  String title;
  String? subTitle;
  bool isCompleted;
  DateTime createdAt;

  TaskModel({
    required this.title,
<<<<<<< HEAD
    this.subTitle,
=======
    this.subtitle,
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
    this.isCompleted = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
<<<<<<< HEAD
      'subtitle': subTitle,
=======
      'subtitle': subtitle,
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
<<<<<<< HEAD
      subTitle: json['subTitle'],
=======
      subtitle: json['subtitle'],
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

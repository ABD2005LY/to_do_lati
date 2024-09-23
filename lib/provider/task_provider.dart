import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:to_do_lati/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];

  addTask(TaskModel tm) {
    tasks.add(tm);
    storeTasks();
    notifyListeners();
    getTasks();
  }

  delete(TaskModel tm) {
    tasks.remove(tm);
    storeTasks();
    notifyListeners();
  }

  edit(TaskModel tm, TaskModel oldTm) {
    tasks.remove(oldTm);
    tasks.add(tm);
    storeTasks();
    notifyListeners();
    getTasks();
  }

  switchValue(TaskModel tm) {
    tm.isCompleted = !tm.isCompleted;
    storeTasks();
    notifyListeners();
    getTasks();
  }

  storeTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json =
        jsonEncode(tasks.map((taskModel) => taskModel.toJson()).toList());
    if (kDebugMode) {
      print("JSON FROM STORE $json");
    }
    prefs.setString("tasks", json);
  }

  getTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("tasks");
    if (kDebugMode) {
      print("JSON FROM GET $data");
    }
    if (data != null) {
      tasks = List<TaskModel>.from(
          jsonDecode(data).map((x) => TaskModel.fromJson(x)));
      notifyListeners();
    }
  }
}

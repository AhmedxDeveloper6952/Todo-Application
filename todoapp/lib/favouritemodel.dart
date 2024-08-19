import 'package:flutter/material.dart';

class Favouritemodel extends ChangeNotifier {
  List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String newTask) {
    _tasks.add(newTask);
    notifyListeners();
  }

  void removeTask(String task) {
    _tasks.remove(task);
    notifyListeners();
  }
}

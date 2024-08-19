import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskModel extends ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get tasks => _tasks;

  Future<void> addTask(String newTask) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> taskData = {
        'task': newTask,
        'completed': false,
        'timestamp': FieldValue.serverTimestamp(),
      };
      _tasks.add(taskData);
      notifyListeners();

      // Add task to Firestore under the user's UID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .add(taskData);
    }
  }

  Future<void> fetchTasks() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tasks')
          .get();

      _tasks = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'task': data['task'],
          'completed':
              data.containsKey('completed') ? data['completed'] : false,
          'id': doc.id,
        };
      }).toList();
      notifyListeners();
    }
  }

  Future<void> updateTask(String oldTask, String newTask) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      int taskIndex =
          _tasks.indexWhere((taskData) => taskData['task'] == oldTask);
      if (taskIndex != -1) {
        _tasks[taskIndex]['task'] = newTask;
        notifyListeners();

        // Update task in Firestore
        String taskId = _tasks[taskIndex]['id'];
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks')
            .doc(taskId)
            .update({'task': newTask});
      }
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      int taskIndex = _tasks.indexWhere((taskData) => taskData['id'] == taskId);
      if (taskIndex != -1) {
        _tasks[taskIndex]['completed'] = isCompleted;
        notifyListeners();

        // Update task completion status in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks')
            .doc(taskId)
            .update({'completed': isCompleted});
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      int taskIndex = _tasks.indexWhere((taskData) => taskData['id'] == taskId);
      if (taskIndex != -1) {
        _tasks.removeAt(taskIndex);
        notifyListeners();

        // Delete task from Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('tasks')
            .doc(taskId)
            .delete();
      }
    }
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'task.dart';

class TaskProvider with ChangeNotifier {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref("tasks");
  List<Task> tasks = [];

  // Fetching all tasks from Firebase Realtime Database
  void fetchTasks() async {
    try {
      DatabaseEvent event = await _databaseReference.child('tasks').once();
      final data = event.snapshot.value;

      if (data != null) {
        final map = (data as Map).cast<String, dynamic>();
        tasks = map.entries
            .map((e) => Task(
                  id: e.key,
                  title: e.value['title'] as String,
                  isCompleted: e.value['isCompleted'] as bool,
                ))
            .toList();
        notifyListeners();
        print("Fetching successful");
      }
    } catch (error) {
      debugPrint("Error fetching tasks: $error");
    }
  }

  // Adding a new task to Firebase Realtime Database
  Future<void> addTask(String title) async {
    try {
      final newTask = {
        'title': title.replaceAll(RegExp(r'[.#$[\]]'), '_'),
        'isCompleted': false,
      };
      await _databaseReference.child('tasks').push().set(newTask);
      fetchTasks(); // Refreshing the task list
      print("Adding successfull");
    } catch (error) {
      debugPrint("Error adding task: $error");
    }
  }

  // Deleting a task by ID
  Future<void> deleteTask(String id) async {
    try {
      await _databaseReference.child('tasks/$id').remove();
      tasks.removeWhere((task) => task.id == id); // Update local list
      print("Deletion successful");
    } catch (error) {
      print("Error deleting task: $error");
    }
    notifyListeners();
  }

  // Updating a task by ID
  Future<void> updateTask(String id, String newTitle, bool newStatus) async {
    try {
      await _databaseReference.child('tasks/$id').update({
        'title': newTitle,
        'isCompleted': newStatus,
      });
      fetchTasks(); //Refresh the task
      print("Updation successful");
    } catch (error) {
      print("Error updating task: $error");
    }
    notifyListeners();
  }
}

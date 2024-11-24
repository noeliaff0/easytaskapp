import 'package:easytaskapp/data/models/task.models.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = []; // Lista de tareas con el nuevo modelo

  List<Task> get tasks => _tasks;

  void addTask(String name, String time, Color color) {
    _tasks.add(Task(name: name, time: time, color: color));
    notifyListeners(); // Notifica a los widgets que el estado cambió
  }
}

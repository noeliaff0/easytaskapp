import 'dart:ui';

class Task {
  final String name;
  final String time; // Puedes usar DateTime para mayor control
  final Color color;

  Task({required this.name, required this.time, required this.color});
}

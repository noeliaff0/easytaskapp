import 'package:easytaskapp/presentation/providers/task.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          return taskProvider.tasks.isEmpty
              ? const Center(
                  child: Text(
                    "No tasks today,\nAdd a new one to get started",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.tasks[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: task.color,
                      ),
                      title: Text(task.name),
                      subtitle: Text(task.time),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Muestra el diálogo para añadir una nueva tarea
          showDialog(
            context: context,
            builder: (context) {
              return const AddTaskDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  Color _selectedColor = Colors.blue; // Color por defecto

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Task"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Task Name"),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: "Task Time"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select Color:"),
                DropdownButton<Color>(
                  value: _selectedColor,
                  onChanged: (newColor) {
                    setState(() {
                      _selectedColor = newColor!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Colors.blue,
                      child: Text("Blue"),
                    ),
                    DropdownMenuItem(
                      value: Colors.red,
                      child: Text("Red"),
                    ),
                    DropdownMenuItem(
                      value: Colors.green,
                      child: Text("Green"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final taskName = _nameController.text;
            final taskTime = _timeController.text;

            if (taskName.isNotEmpty && taskTime.isNotEmpty) {
              // Agrega la tarea al Provider sin redibujar la pantalla completa
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(taskName, taskTime, _selectedColor);
              Navigator.of(context).pop(); // Cierra el diálogo
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}

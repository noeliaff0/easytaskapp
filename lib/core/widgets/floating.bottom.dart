import 'package:flutter/material.dart';

class FloatingABottom extends StatelessWidget {
  final List<String> tasks = []; // Store tasks
  FloatingABottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFFE6198F),
      child: const Icon(
        size: 40,
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddTaskDialog(
            onAddTask: (task) {},
          ),
        );
      },
    );
  }

  void setState(Null Function() param0) {}
}

class AddTaskDialog extends StatefulWidget {
  final Function(String) onAddTask; // Callback function to add a task

  const AddTaskDialog({required this.onAddTask, super.key});

  @override
  AddTaskDialogState createState() => AddTaskDialogState();
}

class AddTaskDialogState extends State<AddTaskDialog> {
  final _taskController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    // Request focus when the dialog is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: screenWidth,
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffE6198F),
              blurRadius: 3,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: TextField(
                focusNode: _focusNode,
                controller: _taskController,
                cursorColor: Colors.pink,
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  hintStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 225, 189, 210)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: Color(0xffE6198F), // Border color when focused
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

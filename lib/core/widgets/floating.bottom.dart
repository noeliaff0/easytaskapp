import 'package:flutter/material.dart';

class FloatingABottom extends StatelessWidget {
  FloatingABottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 124, 113, 120),
      child: const Icon(
        size: 40,
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}

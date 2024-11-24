import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtomRow extends StatelessWidget {
  const IconButtomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 22, 0),
      child: Row(
        children: [
          IconButton(
            color: const Color(0xFF732652),
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          IconButton(
            color: const Color(0xFF732652),
            icon: const Icon(CupertinoIcons.calendar),
            onPressed: () {},
          ),
          IconButton(
            color: const Color(0xFF732652),
            icon: const Icon(CupertinoIcons.person),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

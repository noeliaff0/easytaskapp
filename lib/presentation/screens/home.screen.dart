import 'package:easytaskapp/presentation/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}

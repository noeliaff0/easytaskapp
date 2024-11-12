import 'package:easytaskapp/presentation/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isRegistering = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isRegistering ? 'Register' : 'Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_isRegistering)
              TextField(
                controller: _confirmPasswordController,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);

                // Verificación de coincidencia de contraseñas
                if (_isRegistering &&
                    _passwordController.text !=
                        _confirmPasswordController.text) {
                  setState(() {
                    _errorMessage = 'Passwords do not match';
                  });
                  return;
                }

                try {
                  if (_isRegistering) {
                    await authProvider.registerWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                  } else {
                    await authProvider.signInWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                  }
                } catch (e) {
                  setState(() {
                    _errorMessage = e.toString();
                  });
                }
              },
              child: Text(_isRegistering ? 'Register' : 'Login'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isRegistering = !_isRegistering;
                  _errorMessage = null; // Restablece el mensaje de error
                });
              },
              child: Text(_isRegistering
                  ? 'Already have an account? Login'
                  : 'Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}

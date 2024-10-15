import 'package:flutter/material.dart';
import 'auth_service.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'student'; // Default role

  void _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Call sign up or sign in
    final user = await AuthService().signUp(email, password, _selectedRole);
    if (user == null) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        DropdownButton<String>(
          value: _selectedRole,
          onChanged: (String? newValue) {
            setState(() {
              _selectedRole = newValue!;
            });
          },
          items: <String>['student', 'admin', 'sub-admin']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'product_list_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Número de Teléfono'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                await authService.signInWithPhone(_phoneController.text, _passwordController.text);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ProductListScreen()));
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                authService.signUpWithPhone(_phoneController.text, _passwordController.text);
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}

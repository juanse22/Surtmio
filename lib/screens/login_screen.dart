import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png', // Ruta del logo
          height: 30, // Tamaño del logo
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo en el centro
            Image.asset(
              'assets/logo.png', // Ruta del logo
              height: 100, // Tamaño del logo
            ),
            SizedBox(height: 32),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Número de Teléfono',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Lógica de inicio de sesión
                print('Iniciar sesión');
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Text('Iniciar Sesión'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Lógica de registro
                print('Registrarse');
              },
              child: Text('¿No tienes una cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}

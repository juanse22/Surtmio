import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'services/auth_service.dart'; // Importa el servicio de autenticación
import 'screens/login_screen.dart'; // Importa la pantalla de inicio de sesión
import 'screens/home_screen.dart'; // Importa la pantalla de inicio (HomeScreen)

void main() async {
  // Asegúrate de que Flutter esté listo antes de inicializar Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Ejecuta la aplicación
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Aplicación para Tendero',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        home: LoginScreen(), // Pantalla inicial: LoginScreen
        routes: {
          '/home': (context) => HomeScreen(), // Define la ruta para HomeScreen
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:surtmio/main.dart'; // Asegúrate de que esta ruta sea correcta

void main() {
  testWidgets('Prueba de inicio de la aplicación', (WidgetTester tester) async {
    // Construye nuestra aplicación y activa el mecanismo de detección de cambios.
    await tester.pumpWidget(MyApp()); // Eliminamos `const`

    // Verifica que el texto "Inicio de Sesión" esté presente.
    expect(find.text('Inicio de Sesión'), findsOneWidget);
  });
}

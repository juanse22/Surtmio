import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  String getProductDescription(String productName) {
    switch (productName.toLowerCase()) {
      case 'papel higiénico':
        return 'Nuestro papel higiénico es suave y resistente. Ideal para mantener tu higiene diaria sin preocupaciones. Disponible en diferentes tamaños y paquetes.';
      case 'pimienta':
        return 'La pimienta en grano es una especia versátil que aromatiza y realza el sabor de tus platos. Perfecta para cocinas gourmet y uso diario.';
      case 'arroz':
        return 'Nuestro arroz es de grano largo y de alta calidad. Es perfecto para platos de todo tipo, desde guisos y paellas hasta risottos y sushi.';
      case 'aceite':
        return 'Este aceite es ideal para cocinar y aliñar tus platos. Rico en ácidos grasos saludables, es perfecto para freír, saltear o usar en ensaladas.';
      case 'leche':
        return 'Nuestra leche es fresca y de primera calidad, sin conservantes ni aditivos. Perfecta para tomar directamente, hacer postres o usar en tus recetas diarias.';
      default:
        return 'Este es un producto de alta calidad. Ideal para uso diario.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              product['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product['price']}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              getProductDescription(product['name']),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica para el pago
                // Por ejemplo, abrir un diálogo para seleccionar método de pago
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Comprar ahora',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

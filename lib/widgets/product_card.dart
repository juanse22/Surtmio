import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(product['name']),
        subtitle: Text('Precio: ${product['price']}'),
        trailing: Text('Stock: ${product['stock']}'),
      ),
    );
  }
}

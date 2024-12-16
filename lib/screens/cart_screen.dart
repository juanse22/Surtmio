import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Lista de productos en el carrito
  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Papel Higiénico",
      "price": 1500,
      "image": "assets/papel_higiénico.png",
      "quantity": 2,
    },
    {
      "name": "Pimienta",
      "price": 800,
      "image": "assets/pimienta.png",
      "quantity": 1,
    },
  ];

  // Método de pago seleccionado
  String selectedPaymentMethod = 'Nequi'; // Por defecto, Nequi

  // Calcular el total del carrito
  int get totalAmount {
    return cartItems.fold(0, (sum, item) {
      // Convierte los valores a int explícitamente
      int price = item['price'] as int;
      int quantity = item['quantity'] as int;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(
                    item['image'],
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']} x ${item['quantity']} = \$${item['price'] * item['quantity']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (item['quantity'] > 1) {
                              item['quantity']--;
                            } else {
                              cartItems.removeAt(index);
                            }
                          });
                        },
                      ),
                      Text('${item['quantity']}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            item['quantity']++;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$$totalAmount',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Opciones de pago
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                  items: <String>['Nequi', 'PSE', 'Bancolombia']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para procesar el pago
                    _processPayment(selectedPaymentMethod);
                  },
                  child: Text('Procesar Pago'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Lógica para procesar el pago
  void _processPayment(String paymentMethod) {
    // Aquí puedes implementar la lógica para procesar el pago
    print('Procesando pago con $paymentMethod');
    // Ejemplo: Mostrar un diálogo de confirmación
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pago Exitoso'),
          content: Text('Tu pago con $paymentMethod ha sido procesado correctamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

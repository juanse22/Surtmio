import 'package:flutter/material.dart';
import 'package:surtmio/screens/cart_screen.dart'; // Importa el archivo del carrito

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de productos (puedes reemplazar esto con datos dinámicos)
  final List<Map<String, dynamic>> products = [
    {
      "name": "Papel Higiénico",
      "price": 1500,
      "image": "assets/papel_higiénico.png",
      "quantity": 0,
    },
    {
      "name": "Pimienta",
      "price": 800,
      "image": "assets/pimienta.png",
      "quantity": 0,
    },
    {
      "name": "Arroz",
      "price": 2000,
      "image": "assets/arroz.png",
      "quantity": 0,
    },
    {
      "name": "Aceite",
      "price": 3000,
      "image": "assets/aceite.png",
      "quantity": 0,
    },
    {
      "name": "Leche",
      "price": 1800,
      "image": "assets/leche.png",
      "quantity": 0,
    },
  ];

  // Lista filtrada de productos
  List<Map<String, dynamic>> filteredProducts = [];

  // Controlador para la barra de búsqueda
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa la lista filtrada con todos los productos
    filteredProducts = List.from(products);
  }

  // Función para filtrar productos
  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // Ruta del logo
              height: 30, // Tamaño del logo
            ),
            SizedBox(width: 8),
            Text('Bienvenido'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Aquí puedes implementar la lógica para cerrar sesión
              print('Cerrar sesión');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Search Here...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Lista de productos
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de columnas
                childAspectRatio: 0.8, // Relación de aspecto
                crossAxisSpacing: 16, // Espacio entre columnas
                mainAxisSpacing: 16, // Espacio entre filas
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen del producto
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      // Detalles del producto
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '\$${product['price']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Botones para ajustar la cantidad
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (product['quantity'] > 0) {
                                        product['quantity']--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${product['quantity']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      product['quantity']++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Botón del carrito de compras en la parte inferior
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Carrito',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navega al carrito de compras
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

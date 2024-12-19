import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:surtmio/provider/cart_provider.dart';
import 'package:surtmio/screens/cart_screen.dart';
import 'package:surtmio/screens/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
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
    // Nuevos productos
    {
      "name": "Pan",
      "price": 500,
      "image": "assets/pan.png",
      "quantity": 0,
    },
    {
      "name": "Huevos",
      "price": 1200,
      "image": "assets/huevos.png",
      "quantity": 0,
    },
    {
      "name": "Queso",
      "price": 2500,
      "image": "assets/queso.png",
      "quantity": 0,
    },
    {
      "name": "Jabón",
      "price": 700,
      "image": "assets/jabon.png",
      "quantity": 0,
    },
    {
      "name": "Café",
      "price": 3500,
      "image": "assets/cafe.png",
      "quantity": 0,
    },
  ];

  List<Map<String, dynamic>> filteredProducts = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  String currentSuggestion = "";
  int currentSuggestionIndex = 0;

  @override
  void initState() {
    super.initState();
    filteredProducts = products;

    // Iniciar el carrusel de sugerencias
    startSuggestionCarousel();

    // Escuchar cambios en el controlador de búsqueda
    searchController.addListener(() {
      setState(() {
        isSearching = searchController.text.isNotEmpty;
        if (isSearching) {
          stopSuggestionCarousel(); // Detener el carrusel de sugerencias
          currentSuggestion = ""; // Borrar la sugerencia actual
        }
        filterProducts(searchController.text);
      });
    });
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
          product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Iniciar el carrusel de sugerencias
  void startSuggestionCarousel() {
    Future.delayed(Duration(seconds: 2), () {
      if (!isSearching) {
        setState(() {
          currentSuggestion = products[currentSuggestionIndex]['name'];
          currentSuggestionIndex =
              (currentSuggestionIndex + 1) % products.length;
        });
        startSuggestionCarousel(); // Repetir el ciclo
      }
    });
  }

  // Detener el carrusel de sugerencias
  void stopSuggestionCarousel() {
    setState(() {
      currentSuggestion = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 30,
            ),
            SizedBox(width: 8),
            Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Perfil'),
              onTap: () {
                // Lógica para ir al perfil
              },
            ),
            ListTile(
              title: Text('Cerrar Sesión'),
              onTap: () {
                // Lógica para cerrar sesión
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Contenedor para el PageView
          if (!isSearching)
            Container(
              height: 200,
              child: PageView(
                controller: _pageController,
                children: [
                  Image.asset('assets/promo1.png', fit: BoxFit.cover),
                  Image.asset('assets/promo2.png', fit: BoxFit.cover),
                  Image.asset('assets/promo3.png', fit: BoxFit.cover),
                ],
              ),
            ),
          // Indicador de página
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey,
                ),
              ),
            ),
          // Barra de búsqueda con sugerencias animadas
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500), // Animación suave
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: TextField(
                key: ValueKey(currentSuggestion), // Cambia la clave para animar
                controller: searchController,
                onChanged: filterProducts,
                decoration: InputDecoration(
                  hintText: currentSuggestion.isEmpty
                      ? 'Buscar productos...'
                      : currentSuggestion,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          // Lista de productos
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Selector de cantidad
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
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
                                    style: TextStyle(fontSize: 14),
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
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  if (product['quantity'] > 0) {
                                    cartProvider.addToCart(product);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('${product['name']} añadido al carrito')),
                                    );
                                  }
                                },
                                child: Text('Agregar al Carrito'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Botón del carrito en la parte inferior
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
        child: Stack(
          children: [
            Icon(Icons.shopping_cart),
            if (cartProvider.cartItems.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '${cartProvider.cartItems.length}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

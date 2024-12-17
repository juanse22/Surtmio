import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get totalAmount {
    return _cartItems.fold(0, (sum, item) {
      int price = item['price'] as int;
      int quantity = item['quantity'] as int;
      return sum + (price * quantity);
    });
  }

  void addToCart(Map<String, dynamic> product) {
    final existingItem = _cartItems.firstWhere(
          (item) => item['name'] == product['name'],
      orElse: () => {},
    );

    if (existingItem.isEmpty) {
      _cartItems.add({...product, 'quantity': 1});
    } else {
      existingItem['quantity']++;
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['name'] == product['name']);
    notifyListeners();
  }

  void updateQuantity(Map<String, dynamic> item, param1) {}
}

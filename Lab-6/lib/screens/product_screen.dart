import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'cart_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  static const List<String> products = [
    'iPhone 15',
    'MacBook Pro',
    'AirPods Pro',
    'iPad Air',
    'Apple Watch',
    'Magic Mouse',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2: Products'),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, size: 40),
              title: Text(products[index]),
              subtitle: Text('\$${(index + 1) * 199}.99'),
              trailing: ElevatedButton(
                onPressed: () {
                  context.read<CartModel>().addItem(products[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${products[index]} added!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ),
          );
        },
      ),
    );
  }
}

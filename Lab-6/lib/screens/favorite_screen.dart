import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 1: Favorite Toggle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<FavoriteModel>(
              builder: (context, model, child) {
                return IconButton(
                  iconSize: 80,
                  icon: Icon(
                    model.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: model.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: model.toggleFavorite,
                );
              },
            ),
            const SizedBox(height: 20),
            Consumer<FavoriteModel>(
              builder: (context, model, child) {
                return Text(
                  model.isFavorite ? 'Added to favorites!' : 'Not in favorites',
                  style: Theme.of(context).textTheme.titleLarge,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

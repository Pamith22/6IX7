// price_navigation.dart
import 'package:flutter/material.dart';

class PriceNavigation extends StatelessWidget {
  final VoidCallback onPressed;

  const PriceNavigation({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Subtotal: \$9.25",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }
}
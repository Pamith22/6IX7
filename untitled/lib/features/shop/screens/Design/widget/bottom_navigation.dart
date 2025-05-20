import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onTabTapped;
  final int selectedIndex;
  final VoidCallback? onProductTab; // Ensure it's a function

  const BottomNavBar({
    super.key,
    required this.onTabTapped,
    required this.selectedIndex,
    this.onProductTab,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == 0 && onProductTab != null) {
          onProductTab!(); // Execute the onProductTab function if defined
        }
        onTabTapped(index); // Always switch the tab
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Product"),
        BottomNavigationBarItem(icon: Icon(Icons.brush), label: "Design"),
      ],
    );
  }
}

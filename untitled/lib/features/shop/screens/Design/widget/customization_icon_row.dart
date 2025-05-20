import 'package:flutter/material.dart';

class CustomizationIconsRow extends StatelessWidget {
  final VoidCallback onPrintPressed;
  final VoidCallback onBackPressed;

  const CustomizationIconsRow({
    super.key,
    required this.onPrintPressed,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 16), // Left padding
          _buildIconButton(
            icon: Icons.design_services,
            label: '',
            onPressed: onPrintPressed,
          ),
          const SizedBox(width: 24), // Spacing between icons
          _buildIconButton(
            icon: Icons.image,
            label: '',
            onPressed: onBackPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 28), // Increased icon size
          onPressed: onPressed,
        ),
        Text(label),
      ],
    );
  }
}
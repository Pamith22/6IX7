import 'dart:ui';

import 'package:flutter/material.dart';

class DesignScrollingTabBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onAddDesign;
  final VoidCallback onSaveDesign;
  final VoidCallback onTransform;
  final VoidCallback onCrop;
  final VoidCallback onPosition;

  const DesignScrollingTabBar({
    super.key,
    required this.onBack,
    required this.onAddDesign,
    required this.onSaveDesign,
    required this.onTransform,
    required this.onCrop,
    required this.onPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTabButton('Add Design', onAddDesign),
                _buildTabButton('Save Design', onSaveDesign),
                const VerticalDivider(thickness: 1, width: 20),
                _buildTabButton('Transform', onTransform),
                _buildTabButton('Crop', onCrop),
                _buildTabButton('Position', onPosition),
              ].map((widget) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: widget,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
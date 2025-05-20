import 'dart:io';

import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/crop_dialog.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/position_dialog.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/save_editor.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/transform_dialog.dart';

class ImageEditingToolsPanel extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onAddDesignPressed;
  final File designImage; // Add this line (assuming you have the file reference)

  const ImageEditingToolsPanel({
    super.key,
    required this.onBackPressed,
    required this.onAddDesignPressed,
    required this.designImage, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: onBackPressed,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildToolButton(
                  icon: Icons.add_photo_alternate,
                  label: 'Add Design',
                  onPressed: onAddDesignPressed,
                ),
                _buildToolButton(
                  icon: Icons.save,
                  label: 'Save',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SaveDesignDialog(
                        designImage: designImage,
                        onSave: () {
                          // Implement save functionality
                          Navigator.pop(context);
                        },
                        onCancel: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
                _buildToolButton(
                  icon: Icons.transform,
                  label: 'Transform',
                  onPressed: () {
                   showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const TransformDialog(),
    );
    },
                ),
                _buildToolButton(
                  icon: Icons.open_with,
                  label: 'Position',
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const PositionDialog(),
                    );
                   },
                ),
                _buildToolButton(
                  icon: Icons.crop,
                  label: 'Crop',
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const CropDialog(),
                        shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: Colors.black),
          onPressed: onPressed,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
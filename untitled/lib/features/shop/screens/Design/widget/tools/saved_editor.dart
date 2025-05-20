import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../../utils/constants/image_strings.dart';

class SavedDesignsDialog extends StatelessWidget {
  const SavedDesignsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white,
      ),
      child: SingleChildScrollView( // <-- Added this
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Saved designs (2)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            SizedBox(
              height: 200, // Keep existing height for horizontal list
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDesignPreview('Design 1', TImages.template),
                  const SizedBox(width: 16),
                  _buildDesignPreview('Design 2', TImages.template1),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Keep existing _buildDesignPreview method unchanged
  Widget _buildDesignPreview(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
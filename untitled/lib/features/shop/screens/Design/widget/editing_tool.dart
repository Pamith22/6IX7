import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/clipart_section.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/quick_image_design.dart';

class EditingToolsPanel extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onUploadPressed;
  final VoidCallback onTextPressed;
  final VoidCallback onSavePressed;
  final BuildContext context;
  final Function(String)? onClipartSelected;
  const EditingToolsPanel({
    super.key,
    required this.onBackPressed,
    required this.onUploadPressed,
    required this.onTextPressed,
    required this.onSavePressed, required this.context, this.onClipartSelected,
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
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.upload, color: Colors.black),
                      onPressed: onUploadPressed,
                    ),
                    const Text('Upload', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.text_fields, color: Colors.black),
                      onPressed: onTextPressed,
                    ),
                    const Text('Text', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.save, color: Colors.black),
                      onPressed: onSavePressed,
                    ),
                    const Text('Save', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image, color: Colors.black),
                      onPressed: () async {
    final pattern = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => QuickDesignsScreen()),
    );
    if (pattern != null) {
    // Apply the pattern logic (e.g., set image)
    print("Selected pattern: $pattern");} }

                    ),
                    const Text('Image', style: TextStyle(fontSize: 12)),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.color_lens, color: Colors.black),
                      onPressed: () async {
    final selectedClipart = await Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>  ClipartSelectionScreen(),
    ),
    );
    if (selectedClipart != null && onClipartSelected != null) {
    onClipartSelected!(selectedClipart);} }
                    ),
                    const Text('Clipart', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

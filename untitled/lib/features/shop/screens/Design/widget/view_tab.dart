import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/Design/widget/sketch_grid_view.dart';

class ViewSelectionTabs extends StatelessWidget {
  final String selectedView;
  final Function(String) onTabSelected;
  final VoidCallback onPrintPressed;
  final Map<String, String> imageMap; // Add imageMap parameter

  const ViewSelectionTabs({
    super.key,
    required this.selectedView,
    required this.onTabSelected,
    required this.onPrintPressed,
    required this.imageMap, // Mark as required
  });

  @override
  Widget build(BuildContext context) {
    List<String> views = ["Front", "Back", "Left Sleeve", "Right Sleeve"];

    return Row(
      children: [
        // Grid icon with divider
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.grid_view, size: 24),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SketchGridView(
                    imageMap: imageMap,
                    currentView: selectedView,
                    onViewSelected: (view) => onTabSelected(view),
                  ),
                ),
              ),
              padding: const EdgeInsets.only(left: 16, right: 8),
            ),
            Container(
              height: 24,
              width: 1,
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[400],
            ),
          ],
        ),

        // Scrollable tabs
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: views.map((view) {
                bool isSelected = selectedView == view;
                return GestureDetector(
                  onTap: () => onTabSelected(view),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.yellow : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      view,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
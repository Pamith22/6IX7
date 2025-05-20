import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SketchGridView extends StatelessWidget {
  final Map<String, String> imageMap;
  final String currentView;
  final Function(String) onViewSelected;

  const SketchGridView({
    super.key,
    required this.imageMap,
    required this.currentView,
    required this.onViewSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, String>> sketchEntries = [
      MapEntry("Front", imageMap["FrontSketch"]!),
      MapEntry("Back", imageMap["BackSketch"]!),
      MapEntry("Left Sleeve", imageMap["LeftSleeveSketch"]!),
      MapEntry("Right Sleeve", imageMap["RightSleeveSketch"]!),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Back to design view'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: sketchEntries.length,
        itemBuilder: (context, index) {
          final entry = sketchEntries[index];
          return GestureDetector(
            onTap: () {
              onViewSelected(entry.key);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: currentView == entry.key
                      ? Colors.blue
                      : Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  entry.value,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

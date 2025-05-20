import 'package:flutter/material.dart';
import 'package:untitled/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/image_strings. dart.dart';

class ClipartSelectionScreen extends StatelessWidget {
  final Map<String, List<String>> clipartCategories = {
    'Animals': [
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,

    ],
    'Holidays': [
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,
    ],
    'Symbols': [
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,
      TImages.productImage1,
    ],
  };

  ClipartSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: clipartCategories.keys.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Clipart Library"),
          bottom: TabBar(
            isScrollable: true,
            tabs: clipartCategories.keys.map((String category) {
              return Tab(text: category);
            }).toList(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search clipart...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  children: clipartCategories.entries.map((entry) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: entry.value.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pop(context, entry.value[index]),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                entry.value[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
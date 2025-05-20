import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? selectedSize;
  String? selectedPrinting;
  int selectedColorIndex = -1;

  final List<Color> colors = List.generate(11, (index) => Colors.primaries[index]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title and Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Product",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Product Name
            const Text(
              "Unisex Classic Tee | Glidan 5000",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 8),

            // Ratings
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                const Text(
                  "4.5",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 4),
                Text(
                  "Reviews",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Pricing & Guidelines
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Pricing"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("File Guidelines"),
                ),
              ],
            ),

            const Divider(height: 32),

            // Printing Type Dropdown
            DropdownButtonFormField<String>(
              value: selectedPrinting,
              decoration: const InputDecoration(
                labelText: "Printing Type",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: "DTG", child: Text("DTG Printing")),
                DropdownMenuItem(
                    value: "Embroidery", child: Text("Embroidery")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPrinting = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Color Selection
            const Text(
              "Colors",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: colors.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => setState(() => selectedColorIndex = index),
                child: Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: selectedColorIndex == index
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Size Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Size",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Size Guide"),
                ),
              ],
            ),

            // Size Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["S", "M", "L", "XL"].map((size) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: selectedSize == size
                        ? Colors.blue.withOpacity(0.1)
                        : null,
                  ),
                  onPressed: () => setState(() => selectedSize = size),
                  child: Text(size),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
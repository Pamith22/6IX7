import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_controller.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_model.dart';
import 'package:untitled/utils/constants/sizes.dart';

import '../../../../../common/widgets/product_cards/product_card_vertical.dart';

class SubcategoryProductsScreen extends StatelessWidget {
  final String subcategoryId;

  const SubcategoryProductsScreen({super.key, required this.subcategoryId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: StreamBuilder<List<ProductModel>>(
        stream: controller.streamProductsBySubcategory(subcategoryId),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Handle empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          // Show products grid
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: TSizes.gridViewSpacing,
              crossAxisSpacing: TSizes.gridViewSpacing,
              mainAxisExtent: 288,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => TProductCardVertical(
              product: products[index],
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_controller.dart';

import '../../shop/screens/product_details/product backend/SubcategoryProductsScreen.dart';

class SubcategoryItem extends StatelessWidget {
  final String subcategoryId;
  final String subcategoryName;

  const SubcategoryItem({
    super.key,
    required this.subcategoryId,
    required this.subcategoryName,
  });

  void onSubcategorySelected(String subcategoryId) {
    final productController = Get.find<ProductController>();
    productController.fetchProductsBySubcategory(subcategoryId);
    Get.to(() => SubcategoryProductsScreen(subcategoryId: subcategoryId));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(subcategoryName),
      onTap: () => onSubcategorySelected(subcategoryId),
    );
  }
}
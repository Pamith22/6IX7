// category_tab.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/common/widgets/layouts/grid_layout.dart';
import 'package:untitled/common/widgets/product_cards/product_card_vertical.dart';
import 'package:untitled/features/shop/screens/product_details/product backend/product_model.dart';
import 'package:untitled/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  final String subcategoryId;
  const TCategoryTab({super.key, required this.subcategoryId});

  @override
  Widget build(BuildContext context) {
    final productsQuery = FirebaseFirestore.instance
        .collection('products')
        .where('subcategoryId', isEqualTo: subcategoryId)
        .orderBy('createdAt', descending: true)
        .limit(10);

    return StreamBuilder<QuerySnapshot>(
      stream: productsQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs
            .map((doc) => ProductModel.fromSnapshot(doc))
            .toList();

        return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                    children: [
                      TGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) => TProductCardVertical(
                          product: products[index],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ]
                ),
              ),
            ]
        );
      },
    );
  }
}
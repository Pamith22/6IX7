import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/common/widgets/icon/t_circular_icon.dart';
import 'package:untitled/common/widgets/layouts/grid_layout.dart';
import 'package:untitled/common/widgets/product_cards/product_card_vertical.dart';
import 'package:untitled/features/shop/screens/home/home.dart';
import 'package:untitled/features/shop/screens/product_details/product backend/product_model.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current user ID (replace with your auth implementation)
    final String userId = 'current_user_id'; // Get from Firebase Auth

    // Reference to Firestore products collection
    final favoritesQuery = FirebaseFirestore.instance
        .collection('products')
        .where('favouritedBy', arrayContains: userId)
        .limit(10);

    return Scaffold(
      appBar: TAppBar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favoritesQuery.snapshots(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Extract products from snapshot
          final products = snapshot.data!.docs
              .map((doc) => ProductModel.fromSnapshot(doc))
              .toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TGridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) => TProductCardVertical(
                      product: products[index],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
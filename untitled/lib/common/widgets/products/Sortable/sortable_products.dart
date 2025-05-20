import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/features/shop/screens/product_details/product backend/product_model.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatefulWidget {
  const TSortableProducts({super.key});

  @override
  State<TSortableProducts> createState() => _TSortableProductsState();
}

class _TSortableProductsState extends State<TSortableProducts> {
  String _selectedSortOption = 'Newest';
  final List<String> _sortOptions = [
    'Newest',
    'Name',
    'Higher Price',
    'Lower Price',
    'Sale',
    'Popularity'
  ];

  Query<Map<String, dynamic>> _buildProductsQuery() {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('products')
        .where('published', isEqualTo: true);

    switch (_selectedSortOption) {
      case 'Newest':
        return query.orderBy('createdAt', descending: true);
      case 'Name':
        return query.orderBy('title', descending: false);
      case 'Higher Price':
        return query.orderBy('actualPrice', descending: true);
      case 'Lower Price':
        return query.orderBy('actualPrice', descending: false);
      case 'Sale':
        return query.where('discountPercentage', isGreaterThan: 0);
      case 'Popularity':
        return query.orderBy('popularityScore', descending: true);
      default:
        return query.orderBy('createdAt', descending: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Sorting Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: _selectedSortOption,
          onChanged: (value) {
            setState(() {
              _selectedSortOption = value!;
            });
          },
          items: _sortOptions
              .map((option) => DropdownMenuItem(
            value: option,
            child: Text(option),
          ))
              .toList(),
        ),

        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products Grid
        StreamBuilder<QuerySnapshot>(
          stream: _buildProductsQuery().snapshots(),
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

            return TGridLayout(
              itemCount: products.length,
              itemBuilder: (_, index) => TProductCardVertical(
                product: products[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
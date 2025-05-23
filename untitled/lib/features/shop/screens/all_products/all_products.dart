import 'package:flutter/material.dart';


import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/Sortable/sortable_products.dart';
import '../../../../utils/constants/sizes.dart';



class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
          title: Text('Popular Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TSortableProducts(),
        ),

      ),
    );
  }
}

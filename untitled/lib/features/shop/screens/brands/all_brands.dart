import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/common/widgets/brands/t_brand_card.dart';
import 'package:untitled/common/widgets/layouts/grid_layout.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/features/shop/screens/brands/brands_products.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';


class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: TAppBar(title: Text('Brand'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
           padding: EdgeInsets.all(TSizes.defaultSpace),
           child: Column(
             children: [
               ///heading
             const TSectionHeading(title: 'Brands',showActionButton: false),
             const  SizedBox(height: TSizes.spaceBtwItems),

          ///brands

          TGridLayout(
             itemCount: 10,
             mainAxisExtent:80,
             itemBuilder: (context,index) => TBrandCard(
             showBorder: true,
             onTap: () =>  Get.to(() => const BrandsProducts())),
          ),
    ],
    ),
        ),
      ),
    );


  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:untitled/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:untitled/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:untitled/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:untitled/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:untitled/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../utils/constants/sizes.dart';


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
            children: [

              ///product image slider

              TProductImageSlider(),

              ///product details

              Padding(
                padding: const EdgeInsets.only(right: TSizes.defaultSpace,
                    left: TSizes.defaultSpace,
                    bottom: TSizes.defaultSpace),
                child: Column(
                    children: [

                      ///rating and share button
                      //TRatingAndShare(),


                      ///price, title, stack,and brand
                      TProductMetaData(),


                      ///attributes
                      TProductAttributes(),
                      const SizedBox(height: TSizes.spaceBtwSections),


                      ///Checkout button
                      SizedBox(width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Checkout'))),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      ///Description

                      const TSectionHeading(
                          title: 'Description', showActionButton: false),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      ReadMoreText(
                        'This is a product description for blur cotton shirt. There are more things that can be added but i am just practising and nothing else',
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Less',
                        moreStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        lessStyle: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),

                      ///reviews
                      const Divider(),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TSectionHeading(
                              title: 'Reviews 199', showActionButton: false),
                          IconButton(onPressed: () =>
                              Get.to(() => const ProductReviewsScreen()),
                              icon: const Icon(
                                  Iconsax.arrow_right_3, size: 18)),

                        ],
                      ),

                      const SizedBox(height: TSizes.spaceBtwSections),
                    ]
                ),
              ),
            ]
        ),
      ),
    );
  }
}
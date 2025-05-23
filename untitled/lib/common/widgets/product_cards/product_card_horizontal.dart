import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:untitled/common/widgets/images/t_rounded_image.dart';
import 'package:untitled/common/widgets/texts/product_price_text.dart';
import 'package:untitled/common/widgets/texts/product_title_text.dart';
import 'package:untitled/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings. dart.dart';
import '../../../utils/constants/sizes.dart';

import '../icon/t_circular_icon.dart';


class TProductCardHorizontal  extends StatelessWidget {
  const TProductCardHorizontal ({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
        width: 310,
        padding : const EdgeInsets.all(1),
    decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(TSizes.productImageRadius),
    color: dark ? TColors.darkGrey : TColors.lightcontainer,
    ),

   child: Row(
      children: [
        ///Thumbnail

         TRoundedContainer(
           height : 120,
           padding: const EdgeInsets.all(TSizes.sm),
           backgroundColor: dark ? TColors.dark : TColors.light,
           child:  Stack(
             children: [
               ///thumbnail image
               const SizedBox(
                  height: 120,
                  width: 120,
                  child: TRoundedImage(imageUrl: TImages.productImage1,applyImageRadius: true)
    ),

    Positioned(
    top: 12,
    child: TRoundedContainer(
    radius: TSizes.sm,
    backgroundColor: TColors.secondary.withOpacity(0.8),
    padding: const  EdgeInsets.symmetric(horizontal: TSizes.sm,vertical: TSizes.xs),
    child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
    ),
    ),

    ///favourite icon button
     Positioned(
    top: 0,
    right: 0,
    child:   TCircularIcon(icon: Iconsax.heart5, color: Colors.red),
    ),
    ]
    ),
   ),

        ///details

         SizedBox(
            width: 172,
             child: Padding(
               padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
               child: Column(
                 children: [
                   const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TProductTitleText(title: 'Blue cotton shirt', smallSize: true),
                        SizedBox(height: TSizes.spaceBtwItems/2),
                        TBrandTitleWithVerifiedIcon(title: '6IX7'),
                         ]
                   ),
                      const Spacer(),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                     const  Flexible(child: TProductPriceText(price: '256.0')),
                 ]
                   ),


                 ///add to cart
               Container(
                 decoration: const BoxDecoration(
                   color: TColors.dark,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(TSizes.cardRadiusMd),
                     bottomRight: Radius.circular(TSizes.productImageRadius),
                   ),
                 ),
                 child:const SizedBox(
                   width: TSizes.iconLg * 1.2,
                   height: TSizes.iconLg * 1.2,
                   child: Center( child:  Icon(Iconsax.add, color: TColors.secondary)),
                 ),
               ),
               ],

                  ),
                   ),
         ),
  ],
    ),
             );



  }
}

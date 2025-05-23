import 'package:flutter/material.dart';
import 'package:untitled/common/widgets/images/t_circular_image.dart';
import 'package:untitled/common/widgets/texts/product_price_text.dart';
import 'package:untitled/common/widgets/texts/product_title_text.dart';
import 'package:untitled/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import 'package:untitled/utils/constants/enums.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/constants/sizes.dart';



class TProductMetaData extends StatelessWidget {
  const TProductMetaData({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///price & sale price
          Row(
              children: [

                ///sale tag
                TRoundedContainer(
                  radius: TSizes.sm,
                  backgroundColor: TColors.secondary.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.sm, vertical: TSizes.xs),
                  child: Text('25%', style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black)),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),

                ///price

                Text('Rs 3000', style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
                const SizedBox(width: TSizes.spaceBtwItems),
                const TProductPriceText(price: '2500', isLarge: true),
              ]
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 1.5),


          ///Title

          const TProductTitleText(title: 'Blue cotton Shirt'),
          const SizedBox(height: TSizes.spaceBtwItems / 1.5),


          ///Stock Status

          Row(
            children: [
              const TProductTitleText(title: 'Status'),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text('In Stock', style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 1.5),


          ///Brand
          Row(
              children: [
                TCircularImage(
                  image: TImages.productImage1,
                  width: 32,
                  height: 32,
                  overlayColor: darkMode ? TColors.primary : TColors.black,
                ),

                const TBrandTitleWithVerifiedIcon(
                  title: '6IX7', brandTextSize: TextSizes.medium,),
              ]

          ),
        ]
    );
  }
}

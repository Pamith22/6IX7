import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings. dart.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_funtions.dart';
import '../images/t_rounded_image.dart';
import '../texts/product_title_text.dart';
import '../texts/t_brand_title_with_verified_icon.dart';



class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      ///image
      TRoundedImage(
      imageUrl: TImages.productImage1,
      width: 60,
      height: 60,
      padding: EdgeInsets.all(TSizes.sm),
      backgroundColor: THelperFunctions.isDarkMode(context) ?TColors.darkerGray : TColors.light,
    ),

    const SizedBox(width: TSizes.spaceBtwItems),


    ///title , price and size

    Expanded(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    const TBrandTitleWithVerifiedIcon(title: '6IX7'),
    Flexible(child: TProductTitleText(title: 'Black cotton shirt', maxLines: 1)),
    ///attributes
    Text.rich(
    TextSpan(
    children: [
    TextSpan(text: 'Color',style: Theme.of(context).textTheme.bodySmall),
    TextSpan(text: 'Black',style: Theme.of(context).textTheme.bodyLarge),
    TextSpan(text: 'Size',style: Theme.of(context).textTheme.bodySmall),
    TextSpan(text: 'Medium',style: Theme.of(context).textTheme.bodyLarge),
    ],
    ),
    ),
    ],
    ),
    ),


],
    );
  }
}

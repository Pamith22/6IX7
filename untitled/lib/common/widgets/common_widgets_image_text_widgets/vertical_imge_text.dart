import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_funtions.dart';



class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.primary,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });


  final String image, title;
  final Color textColor;
  final Color ? backgroundColor;
  final void Function()? onTap;

  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(TSizes.sm),
                decoration: BoxDecoration(
                  color: backgroundColor ?? (dark ? TColors.black :TColors.primary),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Image(image:AssetImage(image),fit: BoxFit.cover,color: dark ? TColors.light :TColors.dark,),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems/2,),
              SizedBox(
                width: 70,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]
        ),


      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_funtions.dart';
import '../../styles/spacing_styles.dart';


class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
     body: SingleChildScrollView(
       child: Padding(
         padding: TSpacingStyle.paddingWithAppBarHeight * 2,
         child: Column(
           children: [
         ///image
         Image(image: AssetImage(  image),width: THelperFunctions.screenWidth() * 0.7),
         const SizedBox(height: TSizes.spaceBtwSections),

         /// title and subtitle

         Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
         const SizedBox(height: TSizes.spaceBtwItems),
         Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
         const SizedBox(height: TSizes.spaceBtwSections),

         ///buttons

         SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text(TTexts.tContinue ))),
             const SizedBox(height: TSizes.spaceBtwSections),
           ],
    ),
    ),
    ),
    );
  }
}

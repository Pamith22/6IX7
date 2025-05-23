import 'package:flutter/material.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/constants/sizes.dart';


class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
        children: [
        TSectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: (){}),
    const SizedBox(height: TSizes.spaceBtwItems/2),
    Row(
    children: [
    TRoundedContainer(
    width: 60,
    height: 35,
    backgroundColor: dark ?  TColors.light : TColors.primary,
    padding: const EdgeInsets.all(TSizes.sm),
    child: const Image(image: AssetImage(TImages.productImage1), fit: BoxFit.contain),
    ),
    const SizedBox(height: TSizes.spaceBtwItems/2),
    Text('Paypal', style: Theme.of(context).textTheme.bodyLarge),
    ],
    ),
    ],
    );
  }
}

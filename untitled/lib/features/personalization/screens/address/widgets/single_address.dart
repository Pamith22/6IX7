import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';



class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key, required this.selectedAddress,
  });
  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  TRoundedContainer(
        width: double.infinity,
        padding: const EdgeInsets.all(TSizes.md),
        showBorder: true,
        backgroundColor:selectedAddress ? TColors.black.withOpacity(0.5) : Colors.transparent ,
        borderColor: selectedAddress
        ? Colors.transparent
        : dark
            ? TColors.darkerGray
            : TColors.grey,
    margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
    child: Stack(
      children: [
        Positioned(
           right: 5,
           top: 0,
          child: Icon(
            selectedAddress ? Iconsax.tick_circle5 : null,
            color: selectedAddress
               ? dark
                 ? TColors.light
                 :TColors.dark.withOpacity(0.6)
               :null,
    ),
    ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: Theme.of(context).textTheme.titleLarge,
            ),
              const SizedBox(height: TSizes.sm/2),
              const Text('072-3531387', maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: TSizes.sm/2),
              const Text('36/6 Timmy coves, south liana, maine,67543, USA', softWrap: true),
      ]
    ),
  ]
    ),
    );

        }
}

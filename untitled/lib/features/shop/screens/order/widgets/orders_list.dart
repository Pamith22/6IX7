import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';



class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) =>
          TRoundedContainer(
            showBorder: true,
            padding: EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ///Row1
                  Row(
                      children: [

                        ///1 icon
                        const Icon(Iconsax.ship),
                        const SizedBox(width: TSizes.spaceBtwItems / 2),

                        ///2 Status and date

                        Expanded(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Processing',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                      color: TColors.black, fontWeightDelta: 1),
                                ),
                                Text('07 Nov 2025', style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineSmall),
                              ]
                          ),
                        ),

                        ///icon 3

                        IconButton(onPressed: () {},
                            icon: const Icon(
                                Iconsax.arrow_right_34, size: TSizes.iconSm))
                      ]
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ///Row2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                            children: [

                              ///1 icon
                              const Icon(Iconsax.tag),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),

                              ///2 Status and date

                              Expanded(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Order',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .labelMedium
                                      ),
                                      Text('[#25750]', style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleMedium),
                                    ]
                                ),
                              ),

                            ]
                        ),
                      ),


                      Expanded(
                        child: Row(
                            children: [

                              ///1 icon
                              const Icon(Iconsax.calendar),
                              const SizedBox(width: TSizes.spaceBtwItems / 2),

                              ///2 Status and date

                              Expanded(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Shipping date',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .labelMedium
                                      ),
                                      Text('07 Nov 2025', style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleMedium),
                                    ]
                                ),
                              ),

                            ]
                        ),
                      ),
                    ],
                  ),
                ]
            ),
          ),
    );
  }
}

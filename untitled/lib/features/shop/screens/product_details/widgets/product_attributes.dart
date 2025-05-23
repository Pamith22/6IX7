import 'package:flutter/material.dart';
import 'package:untitled/common/widgets/texts/product_price_text.dart';
import 'package:untitled/common/widgets/texts/product_title_text.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';



class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Column(
          children: [
            ///selected attributes pricing and description
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGray : TColors.grey,
              child:  Column(
                children: [
                  ///title , price and  stock status

                Row(
                  children: [
                    const TSectionHeading(title: 'Variation', showActionButton: false),
                     const SizedBox(width: TSizes.spaceBtwItems),

                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                           Row(
                              children: [
                                 const TProductTitleText(title: 'Price :', smallSize: true),




                  ///Actual price
                       Text(
                         '\$25',
                          style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
    ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                   ///sale price
                          const TProductPriceText(price: '20'),
    ]
    ),


                  ///stock
                  const TProductTitleText(title: 'Stock :', smallSize: true),
                  Text('In stock', style: Theme.of(context).textTheme.titleMedium),


                   ],
                 ),
               ],
              ),
               ///variation Description

                const TProductTitleText(
                title:'This is the Description of the product and it can go up to max 4 lines',
                smallSize: true,
                maxLines: 4
              ),
            ]
           ),
         ),
            const SizedBox(height: TSizes.spaceBtwItems),


            ///Attributes
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: 'Colors', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems/2),
                Wrap(
                  spacing: 8,
                  children: [
                TChoiceChip(text: 'Green',selected: true,onSelected: (value){}),
                TChoiceChip(text: 'Blue',selected: false,onSelected: (value){}),
                TChoiceChip(text: 'Yellow',selected: false,onSelected: (value){}),
    ]
    ),

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  const TSectionHeading(title: 'Size'),
                  const SizedBox(height: TSizes.spaceBtwItems/2),
                  Wrap(
                    spacing: 8,
                    children: [
                  TChoiceChip(text: 'Small',selected: true,onSelected: (value){}),
                  TChoiceChip(text: 'Medium',selected: false,onSelected: (value){}),
                  TChoiceChip(text: 'Large',selected: false,onSelected: (value){}),
    ]
    ),
    ],
    ),
    ],
    ),
    ]

    );





  }
}


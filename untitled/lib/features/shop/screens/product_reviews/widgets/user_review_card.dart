import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:untitled/common/widgets/products/rating/rating_indictor.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/constants/sizes.dart';






class UserReviewCard  extends StatelessWidget {
  const  UserReviewCard ({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
       children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
             children: [
               const CircleAvatar(backgroundImage: AssetImage(TImages.user)),
               const SizedBox(width: TSizes.spaceBtwItems),
               Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
    ]
    ),
    
             IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
    ]
    ),
             const SizedBox(height: TSizes.spaceBtwItems),
    
    
              ///Review
             Row(
              children: [
                const TRatingBarIndicator(rating: 4),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('01 Nov, 2025', style: Theme.of(context).textTheme.bodyMedium,
                ),
    ]
    ),

               const SizedBox(height: TSizes.spaceBtwItems),
               const  ReadMoreText(
                 'The User interface of the app is quite intuitive.I was able to navigate and make purchases seamlessly.Great job!',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'Show less',
                  trimCollapsedText:'show more',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary) ,
    ),

                const SizedBox(height: TSizes.spaceBtwItems),


                 ///review

                 TRoundedContainer(
                   backgroundColor: dark ? TColors.darkerGray : TColors.grey,
                   child: Padding(
                     padding: const EdgeInsets.all(TSizes.md),
                     child: Column(
                      children: [
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("6IX7", style: Theme.of(context).textTheme.titleMedium),
                           Text("02 Nov, 2025", style: Theme.of(context).textTheme.bodyMedium),
    ]
    ),


    const SizedBox(height: TSizes.spaceBtwItems),
    const  ReadMoreText(
    'The User interface of the app is quite intuitive.I was able to navigate and make purchases seamlessly.Great job!',
    trimLines: 2,
    trimMode: TrimMode.Line,
    trimExpandedText: 'Show less',
    trimCollapsedText:'show more',
    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary) ,
    ),
    ]
    ),
    ),
    ),
    const SizedBox(height: TSizes.spaceBtwSections),
    ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:untitled/features/shop/screens/product_reviews/widgets/user_review_card.dart';


import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/rating/rating_indictor.dart';
import '../../../../utils/constants/sizes.dart';



class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///appbar

      appBar: TAppBar(title: Text('Reviews & Rating'), showBackArrow: true),


      ///body

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Ratings and reviews are verified and are from people who use the same type of devise that you use"),
              SizedBox(height: TSizes.spaceBtwItems),


              /// overall product rating
              TOverallProductRating(),
              TRatingBarIndicator(rating: 3.5),
              Text("12 611", style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),


              ///user Review list

              const UserReviewCard(),
            ],
          ),
        ),
      ),

    );
  }
}


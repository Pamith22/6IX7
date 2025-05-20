import 'package:flutter/material.dart';
import 'package:untitled/common/widgets/brands/t_brand_card.dart';
import 'package:untitled/common/widgets/products/Sortable/sortable_products.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';



class BrandsProducts extends StatelessWidget {
  const BrandsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: TAppBar(title:Text( '6IX7')),
       body: SingleChildScrollView(
         child:Padding(
           padding: EdgeInsets.all(TSizes.defaultSpace),
           child: Column(
             children: [
               ///brand details
                TBrandCard(showBorder: true),
                SizedBox(height: TSizes.spaceBtwSections),

                 TSortableProducts(),
           ],
    ),
    ),
    ),
    );
  }
}

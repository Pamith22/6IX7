import 'package:flutter/material.dart';
import 'package:untitled/common/widgets/appbar/tabbar.dart';
import 'package:untitled/common/widgets/brands/t_brand_card.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:untitled/common/widgets/layouts/grid_layout.dart';
import 'package:untitled/common/widgets/products.cart/cart_menu_icon.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/features/shop/screens/store/widgets/category_tab.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: TAppBar(
            title: Text('Store', style: Theme
                .of(context)
                .textTheme
                .headlineMedium),
            actions: [
              TCartCounterIcon(onPressed: () {}),
            ]
        ),

        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors
                  .black : TColors.primary,
              expandedHeight: 130,


              flexibleSpace: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [

                      ///search bar

                      const SizedBox(height: TSizes.spaceBtwItems),
                      const TSearchContainer(text: 'Search in store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero),

                      ///feature brands








                    ]
                ),
              ),



              ),


          ];
        },

          ///body


          body: TabBarView(
            children: [
              TCategoryTab(subcategoryId: '',),

            ],


          ),
        ),
      ),
    );
  }
  }















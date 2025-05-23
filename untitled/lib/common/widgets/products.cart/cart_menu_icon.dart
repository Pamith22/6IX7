import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/features/shop/screens/cart/cart.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../utils/constants/colors.dart';


class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
     required this.onPressed,
     this.iconColor,
     this.counterBgColor,
     this.counterTextColor
  });

  final Color ? iconColor,counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
        children:[
          IconButton(onPressed: () => Get.to(() => const CartScreen() ), icon: Icon(Iconsax.shopping_bag,color:iconColor)),
          Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: counterBgColor ?? (dark ? TColors.black : TColors.primary),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                  child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: counterTextColor,fontSizeFactor: 0.8))),
            ),
          ),
        ]
    );
  }
}



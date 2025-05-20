import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:untitled/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:untitled/features/shop/screens/checkout/checkout.dart';



import '../../../../common/widgets/appbar/appbar.dart';



import '../../../../utils/constants/sizes.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme
          .of(context)
          .textTheme
          .headlineSmall)),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          ///items in cart
          child: TCartItems()
      ),

      ///checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const CheckoutScreen()),
            child: Text('Checkout \$256')),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:untitled/common/widgets/success_screen/success_screen.dart';
import 'package:untitled/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:untitled/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:untitled/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:untitled/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:untitled/navigation_menu.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products.cart/coupon_widget.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings. dart.dart';
import '../../../../utils/constants/sizes.dart';


class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: TAppBar(showBackArrow : true,title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
             children: [
               /// item in cart
             const TCartItems(showAddRemoveButtons: false),
             const SizedBox(height: TSizes.spaceBtwSections),

              ///Coupon Text field
              TCouponCode(),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///billing section
               TRoundedContainer(
                 showBorder: true,
                 padding: const EdgeInsets.all(TSizes.md),
                 backgroundColor: dark ? TColors.black : TColors.primary,
                 child: const Column(
                  children: [
                    ///pricing
                   TBillingAmountSection(),
                    SizedBox(height: TSizes.spaceBtwSections),
                    ///Divider
                    Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                   ///Payment Method
                    TBillingPaymentSection(),
                    SizedBox(height: TSizes.spaceBtwItems),
                  ///Addresses
                    TBillingAddressSection()
                   ]
    ),
    ),
          ]
    ),

    ),

    ),
                    ///checkout button
                 bottomNavigationBar: Padding(
                 padding: const EdgeInsets.all(TSizes.defaultSpace),
                 child: ElevatedButton(
                     onPressed: () => Get.to(
                             () =>  SuccessScreen(
                                 image: TImages.productImage1,
                                 title: 'Payment Success!',
                                 subTitle: 'Your item will be shipped soon',
                                 onPressed: () => Get.offAll(() => const NavigationMenu())
    ),
    ),
                  child: const Text('Checkout \$256.0')),
      ),
    );
  }
}


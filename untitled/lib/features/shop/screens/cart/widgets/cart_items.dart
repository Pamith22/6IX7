import 'package:flutter/material.dart';

import '../../../../../common/widgets/products.cart/add_remove_button.dart';
import '../../../../../common/widgets/products.cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';


class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key, this.showAddRemoveButtons = true,
  });
   final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemCount: 10,
      itemBuilder: (_, index) => Column(
          children: [
            ///cart item
             TCartItem(),
             if(showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
            ///add remove button row with total price
            if(showAddRemoveButtons)
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                      children: [
                        ///extra space
                        const SizedBox(width: 70),
                        ///add remove buttons
                        TProductQuantityWithAddRemoveButton(),
                      ]
                  ),
                  TProductPriceText(price: '256'),

                ]
            ),
          ]
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_funtions.dart';
import '../../../controllers/signup/signup_controller.dart';





class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,
    required this.dark,

  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(
                () => Checkbox(
            value: controller.privacyPolicy.value,
            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value )
        )),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
            TextSpan(text: '${TTexts.privacyPolicy} ', style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: dark ? TColors.black : TColors.black,
              decoration: TextDecoration.underline,
              decorationColor: dark ? TColors.black : TColors.black,
            )),
            TextSpan(text: '${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
            TextSpan(text: TTexts.termsOfUse , style: Theme.of(context).textTheme.bodyMedium!.apply(
              color: dark ? TColors.black: TColors.black,
              decoration: TextDecoration.underline,
              decorationColor: dark ? TColors.black : TColors.black,
            )),
          ]),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/features/authentication/screens/login/widgets/login_form.dart';
import 'package:untitled/features/authentication/screens/login/widgets/login_header.dart';
import 'package:untitled/utils/constants/colors.dart';
import 'package:untitled/utils/constants/text_strings.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';
import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/social_buttons.dart';
import '../../../../utils/constants/sizes.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              children: [
             ///logo title and subtitle
              TLoginHeader(dark: dark),

            ///form

              const LoginForm(),

            ///divider
             TFormDivider(dark: dark),
             const SizedBox(height: TSizes.spaceBtwSections),
            ///footer
             const TSocialButtons(),
           ],
          ),
         ),
        ),
       );
  }
}



class TFormDivider extends StatelessWidget {
  const TFormDivider({ super.key, required this.dark, });


  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Flexible(child: Divider(color: dark ? TColors.darkGrey: TColors.grey,thickness: 0.5,indent: 60,endIndent: 5,)),
       Text(TTexts.orSignInWith.capitalize!, style: Theme.of(context).textTheme.labelMedium,),
       Flexible(child: Divider(color: dark ? TColors.darkGrey: TColors.grey,thickness: 0.5,indent: 5,endIndent: 60,)),

        ],
      );
  }
}





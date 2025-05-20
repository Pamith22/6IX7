import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:untitled/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:untitled/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:untitled/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:untitled/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:untitled/utils/constants/image_strings.%20dart.dart';
import 'package:untitled/utils/constants/text_strings.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';



class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnBoardingController());

    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                dark: dark,
                image: dark
                    ? TImages.onBoardingImage1
                    : TImages.onBoardingDarkImage1,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                dark: dark,
                image: dark
                    ? TImages.onBoardingImage2
                    : TImages.onBoardingDarkImage2,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                dark: dark,
                image: dark
                    ? TImages.onBoardingImage3
                    : TImages.onBoardingDarkImage3,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          ///skip button
          const OnBoardingSkip(),


          ///dot navigation smooth page indicator
          const OnBoardingDotNavigation(),


          ///circular button
          const OnBoardingNextButton()],
      ),
    );
  }
}

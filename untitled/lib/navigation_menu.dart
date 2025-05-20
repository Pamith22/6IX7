import 'package:flutter/material.dart';
import 'package:untitled/features/personalization/screens/settings/settings.dart';
import 'package:untitled/features/shop/screens/home/home.dart';
import 'package:untitled/features/shop/screens/store/store.dart';
import 'package:untitled/features/shop/screens/wishlist/wishlist.dart';
import 'package:untitled/utils/constants/colors.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

import 'features/shop/screens/selection screen/widget/selection_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller outside the build method
    final controller = Get.put(NavigationController());  // Use Get.find to avoid reinitialization
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : Colors.white,
          indicatorColor: darkMode
              ? TColors.textWhite.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(icon: Icon(Iconsax.add), label: 'Design'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),

          ],



        ),
      ),
      body: Obx(
            () => controller.screens[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationController extends GetxController {
  // Define the initial selected index as 0
  final Rx<int> selectedIndex = 0.obs;

  // Screens that correspond to each navigation destination
  final screens = [
    (const HomeScreen()),
    (const StoreScreen()),
    (SelectionScreen()),
    (const FavouriteScreen()),
    (const SettingsScreen()),

  ];
}
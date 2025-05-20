import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:untitled/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:untitled/common/widgets/texts/section_heading.dart';
import 'package:untitled/features/personalization/screens/address/address.dart';
import 'package:untitled/features/shop/screens/order/order.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../profile/profile.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ///header

            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(title: Text('Account', style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.primary))),


                  ///user profile card

                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),

            ),

            ///body

            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [

                  ///account settings

                  TSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),


                  TSettingsMenuTile(icon: Iconsax.safe_home,
                      title: 'My Addresses',
                      subTitle: 'set shopping delivery address',
                      onTap: () => Get.to(() => const UserAddressScreen())),
                  TSettingsMenuTile(icon: Iconsax.shopping_cart,
                      title: 'My cart',
                      subTitle: 'add, remove products and move to checkout',
                      onTap: () {}),
                  TSettingsMenuTile(icon: Iconsax.bag_tick,
                      title: 'My orders',
                      subTitle: 'In_progress and completed orders',
                      onTap: () => Get.to(() => const OrderScreen())),
                  TSettingsMenuTile(icon: Iconsax.bank,
                      title: 'Bank Account',
                      subTitle: 'Withdraw balance to registered bank account',
                      onTap: () {}),
                  TSettingsMenuTile(icon: Iconsax.discount_shape,
                      title: 'My coupons',
                      subTitle: 'List of all the discount coupons',
                      onTap: () {}),
                  TSettingsMenuTile(icon: Iconsax.notification,
                      title: 'Notification',
                      subTitle: 'Set any kind of notification message',
                      onTap: () {}),
                  TSettingsMenuTile(icon: Iconsax.security_card,
                      title: 'Account Privacy',
                      subTitle: 'Manage data usage and connected accounts',
                      onTap: () {}),


                  /// app setting


                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                      title: 'App settings', showActionButton: false),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(icon: Iconsax.document_upload,
                      title: 'Load data',
                      subTitle: 'Upload data to your cloud firebase'),


                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation base on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),


                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),


                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD image quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),


                  ///logout button
                  SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text('Logout'))
                  ),


                  const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/features/shop/screens/home/widgets/shimmer.dart';
import '../../../../../Utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/helper_funtions.dart';
import '../../../../personalization/controllers/user_controller.dart';


class THomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const THomeAppBar({
    super.key,
    this.leadingOnPressed,
    required this.showSetting,
    this.leadingIcon,
    this.actions,
  });

  final VoidCallback? leadingOnPressed;
  final bool showSetting;
  final IconData? leadingIcon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
        padding: const EdgeInsets.only(left: 0, top: 5),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showSetting
              ? IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.setting_2,
              color: dark ? TColors.primary : TColors.dark,
            ),
          )
              : leadingOnPressed != null
              ? IconButton(
            onPressed: leadingOnPressed,
            icon: Icon(leadingIcon),
          )
              : null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  height: 25,
                  width: 90,
                  image: AssetImage(
                      dark ? TImages.darkAppLogo : TImages.lightAppLogo)),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const TShimmerEffect(
                    width: 80,
                    height: 15,
                  );
                } else {
                  return Text(
                    'Hi, ${controller.user.value.fullname}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: const Color.fromARGB(255, 0, 0, 0)),
                  );
                }
              }),
            ],
          ),
          actions: actions,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

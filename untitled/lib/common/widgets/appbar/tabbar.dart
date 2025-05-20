import 'package:flutter/material.dart';
import 'package:untitled/utils/device/device_utility.dart';
import 'package:untitled/utils/helpers/helper_funtions.dart';

import '../../../utils/constants/colors.dart';



class TTabBar extends StatelessWidget implements PreferredSizeWidget {

  const TTabBar ({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
     final dark = THelperFunctions.isDarkMode(context);
     return Material(
      color: dark ? TColors.black : TColors.primary,
      child: TabBar(
        tabs : tabs,
        isScrollable : true,
        indicatorColor : TColors.black,
        labelColor: dark ? TColors.primary : TColors.black,
        unselectedLabelColor : TColors.darkGrey,
     ),
     );


  }

  @override

  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

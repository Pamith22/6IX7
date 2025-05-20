// men_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Utils/constants/colors.dart';
import '../../../../Utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/products.cart/cart_menu_icon.dart';
import '../../../../utils/helpers/helper_funtions.dart';
import '../../../home/subcategory backend/sub_category_controller.dart';
import '../store/widgets/category_tab.dart';

class MenScreen extends StatefulWidget {
  final String categoryId;
  const MenScreen({super.key, required this.categoryId});

  @override
  State<MenScreen> createState() => _MenScreenState();
}

class _MenScreenState extends State<MenScreen> {
  final controller = Get.put(SubcategoryController());

  @override
  void initState() {
    super.initState();
    controller.fetchSubcategoriesByCategoryId(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return DefaultTabController(
        length: controller.subcategories.length,
        child: Scaffold(
          appBar: TAppBar(
            title: Text('Store', style: Theme.of(context).textTheme.headlineMedium),
            actions: [TCartCounterIcon(onPressed: () {})],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.primary,
                  expandedHeight: 170,
                  flexibleSpace: const Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        SizedBox(height: TSizes.spaceBtwItems),
                        TSearchContainer(
                          text: 'Search in store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  bottom: TTabBar(
                    tabs: controller.subcategories
                        .map((sub) => Tab(text: sub.name))
                        .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: controller.subcategories
                  .map((sub) => TCategoryTab(subcategoryId: sub.id))
                  .toList(),
            ),
          ),
        ),
      );
    });
  }
}
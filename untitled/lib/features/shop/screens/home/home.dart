import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/shop/screens/all_products/all_products.dart';
import 'package:untitled/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:untitled/features/shop/screens/home/widgets/home_categorise.dart';
import 'package:untitled/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:untitled/utils/constants/image_strings.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings. dart.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../home/category_backend/add_category_screen.dart';
import '../../../home/category_backend/category_controller.dart';
import '../product_details/product backend/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.put(ProductController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.fetchCategories();
      productController.fetchProductsBySubcategory(''); // Fetch all products
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(showSetting: false),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Search bar
                  const TSearchContainer(text: 'Search'),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        const TSectionHeading(
                          title: 'Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategorise(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [TImages.banner1, TImages.banner2, TImages.banner3],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Popular Products
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () => Get.to(() => AddCategoryScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Product Grid
                  Obx(() {
                    if (productController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (productController.filteredProducts.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }

                    return TGridLayout(
                      itemCount: productController.filteredProducts.length,
                      itemBuilder: (_, index) => TProductCardVertical(
                        product: productController.filteredProducts[index],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


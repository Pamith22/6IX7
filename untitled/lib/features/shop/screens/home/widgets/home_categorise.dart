// Update THomeCategorise widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/common_widgets_image_text_widgets/vertical_imge_text.dart';
import '../../../../home/category_backend/category_controller.dart';
import '../../sub_category/men_screen.dart';

class THomeCategorise extends StatelessWidget {
  const THomeCategorise({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(() {
      if (controller.isLoadingCategories.value) {
        return const SizedBox(
          height: 90,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return SizedBox(
            height: 90,
            child: Center(
              child: Text(
                  'Error loading categories: ${controller.errorMessage.value}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red)),
            ),
            );
        }

            if (controller.categories.isEmpty) {
          return const SizedBox(
            height: 90,
            child: Center(child: Text('No categories found')),
          );
        }

        return SizedBox(
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = controller.categories[index];
              return TVerticalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(() => MenScreen(categoryId: category.id)),
              );
            },
          ),
        );
      });
  }
}
// add_subcategory_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/subcategory%20backend/sub_category_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../category_backend/category_controller.dart';

class AddSubcategoryScreen extends StatelessWidget {
  const AddSubcategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subcategoryController = Get.put(SubcategoryController());
    final categoryController = Get.find<CategoryController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Add Subcategory'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Category Selection Dropdown
            Obx(() {
              if (categoryController.isLoadingCategories.value) {
                return const CircularProgressIndicator();
              }

              if (categoryController.categories.isEmpty) {
                return const Text('No categories found. Please add categories first.');
              }

              return DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Select Category'),
                value: subcategoryController.selectedCategoryId.value.isEmpty
                    ? null
                    : subcategoryController.selectedCategoryId.value,
                items: categoryController.categories.map((category) {
                  return DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  subcategoryController.selectedCategoryId.value = value.toString();
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              );
            }),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Subcategory Name
            TextFormField(
              controller: subcategoryController.nameController,
              decoration: const InputDecoration(
                labelText: 'Subcategory Name',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Submit Button
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: subcategoryController.isLoading.value
                      ? null
                      : () => subcategoryController.addSubcategory(),
                  child: subcategoryController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Add Subcategory'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
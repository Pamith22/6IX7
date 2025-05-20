import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/features/home/subcategory%20backend/sub_category_model.dart';
import 'package:untitled/features/home/subcategory%20backend/sub_category_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../category_backend/category_controller.dart';

class SubcategoryController extends GetxController {
  static SubcategoryController get instance => Get.find();

  final subcategoryRepository = SubcategoryRepository();
  final categoryController = CategoryController.instance;
  final nameController = TextEditingController();
  final selectedCategoryId = RxString('');
  final isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<SubcategoryModel> subcategories = <SubcategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      if (categoryController.categories.isEmpty) {
        await categoryController.fetchCategories();
      }
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to load categories: $e');
    }
  }

  Future<void> fetchSubcategoriesByCategoryId(String categoryId) async {
    try {
      isLoading.value = true;
      subcategories.value = await subcategoryRepository.getSubcategoriesByCategoryId(categoryId);
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to fetch subcategories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSubcategory() async {
    try {
      // Validate form
      if (selectedCategoryId.value.isEmpty || nameController.text.isEmpty) {
        TLoaders.warningSnackBar(title: 'Warning', message: 'Please select a category and enter subcategory name');
        return;
      }

      isLoading.value = true;

      // Generate subcategory ID
      final subcategoryId = await subcategoryRepository.generateSubcategoryId();

      // Create subcategory
      final newSubcategory = SubcategoryModel(
        id: subcategoryId,
        name: nameController.text.trim(),
        categoryId: selectedCategoryId.value,
        createdAt: DateTime.now(),
      );

      // Save to Firestore
      await subcategoryRepository.saveSubcategory(newSubcategory);

      // Reset form
      nameController.clear();
      selectedCategoryId.value = '';

      TLoaders.successSnackBor(title: 'Success', message: 'Subcategory added successfully');
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to add subcategory: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
// category_controller.dart
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/popups/loaders.dart';

import 'category_model.dart';
import 'category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());
  final nameController = TextEditingController();
  final image = Rx<File?>(null);
  final isLoading = false.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoadingCategories = false.obs;
  final RxString errorMessage = ''.obs;


  Future<void> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to pick image: $e');
    }
  }

  Future<void> addCategory() async {
    try {
      if (nameController.text.isEmpty || image.value == null) {
        TLoaders.warningSnackBar(title: 'Warning', message: 'Please fill all fields');
        return;
      }

      isLoading.value = true;

      // Generate ID
      final categoryId = await categoryRepository.generateCategoryId();

      // Upload image
      final imageUrl = await categoryRepository.uploadCategoryImage(
        'categories/$categoryId',
        image.value!,
      );

      // Create category
      final newCategory = CategoryModel(
        id: categoryId,
        name: nameController.text.trim(),
        image: imageUrl,
        createdAt: DateTime.now(),
      );

      // Save to Firestore
      await categoryRepository.saveCategory(newCategory);

      // Reset form
      nameController.clear();
      image.value = null;

      TLoaders.successSnackBor(title: 'Success', message: 'Category added successfully');
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to add category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      errorMessage.value = '';
      final result = await categoryRepository.getAllCategories();
      categories.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
      TLoaders.errorsnackBar(title: 'Error', message: 'Failed to load categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }

  }

}
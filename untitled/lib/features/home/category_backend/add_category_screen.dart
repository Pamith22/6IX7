// add_category_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../shop/screens/product_details/product backend/product_create_screen.dart';
import '../subcategory backend/add_sub_category_screen.dart';
import 'category_controller.dart';
 // Make sure to import your sub-category screen

class AddCategoryScreen extends StatelessWidget {
  AddCategoryScreen({super.key});

  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Category')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Existing Category Form Elements
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => InkWell(
              onTap: controller.pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: controller.image.value != null
                    ? Image.file(controller.image.value!, fit: BoxFit.cover)
                    : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 50),
                    Text('Tap to select image'),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 30),
            Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.addCategory,
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const Text('Submit Category'),
            )),

            // New Action Buttons Section
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            const Text('Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Three Action Buttons in a Column
            Column(
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.category,
                  text: 'Add Sub Category',
                  onPressed: () => Get.to(() =>  AddSubcategoryScreen()),
                ),
                const SizedBox(height: 15),
                _buildActionButton(
                  context,
                  icon: Icons.inventory,
                  text: 'Add New Item',
                  onPressed:  () => Get.to(() =>  ProductCreateScreen()),
                    // Add your item screen navigation here
                    // Get.to(() => AddItemScreen());


                ),
                const SizedBox(height: 15),
                _buildActionButton(
                  context,
                  icon: Icons.list_alt,
                  text: 'View Categories',
                  onPressed: () {
                    // Add your categories list screen navigation here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Action Button Widget
  Widget _buildActionButton(BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 24),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(text, style: Theme.of(context).textTheme.titleMedium),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
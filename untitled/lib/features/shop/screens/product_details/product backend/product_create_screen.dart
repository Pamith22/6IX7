import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/home/category_backend/category_controller.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_controller.dart';

import '../../../../home/subcategory backend/sub_category_controller.dart';

class ProductCreateScreen extends StatelessWidget {
  final ProductController _controller = Get.put(ProductController());
  final CategoryController _categoryController = Get.find();
  final SubcategoryController _subcategoryController = Get.put(SubcategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Create Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller.titleController,
              decoration: const InputDecoration(
                labelText: 'Product Title',
                border: OutlineInputBorder(),
              ),
            ),
            _buildCategoryDropdowns(),
            const SizedBox(height: 20),
            _buildMediaUploader(),
            const SizedBox(height: 20),
            _buildPriceFields(),
            const SizedBox(height: 20),
            _buildColorPicker(),
            const SizedBox(height: 20),
            _buildSizeSelector(),
            const SizedBox(height: 20),
            _buildDescriptionField(),
            const SizedBox(height: 30),
            _buildCreateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDropdowns() {
    return Column(
      children: [
        Obx(() => DropdownButtonFormField(
          value: _controller.selectedCategoryId.value.isEmpty ? null : _controller.selectedCategoryId.value,
          items: _categoryController.categories.map((category) {
            return DropdownMenuItem(
              value: category.id,
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (value) {
            _controller.selectedCategoryId.value = value.toString();
            _subcategoryController.fetchSubcategoriesByCategoryId(value.toString());
          },
          decoration: const InputDecoration(labelText: 'Category'),
        )),
        const SizedBox(height: 10),
        Obx(() => DropdownButtonFormField(
          value: _controller.selectedSubcategoryId.value.isEmpty ? null : _controller.selectedSubcategoryId.value,
          items: _subcategoryController.subcategories.map((subcategory) {
            return DropdownMenuItem(
              value: subcategory.id,
              child: Text(subcategory.name),
            );
          }).toList(),
          onChanged: (value) => _controller.selectedSubcategoryId.value = value.toString(),
          decoration: const InputDecoration(labelText: 'Subcategory'),
        )),
      ],
    );
  }

  Widget _buildMediaUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add Media (max 10)', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._controller.mediaFiles.map((file) => Stack(
              children: [
                Image.file(File(file.path), width: 80, height: 80, fit: BoxFit.cover),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => _controller.mediaFiles.remove(file),
                  ),
                ),
              ],
            )),
            GestureDetector(
              onTap: _controller.pickMedia,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildPriceFields() {
    return Column(
      children: [
        TextFormField(
          controller: _controller.actualPriceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Actual Price'),
        ),
        TextFormField(
          controller: _controller.discountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Discount (%)'),
        ),
        Obx(() => Text(
          'Discounted Price: \$${_controller.discountPrice.value.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        TextFormField(
          controller: _controller.quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantity'),
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    const List<Color> colorPalette = [
      Colors.red, Colors.blue, Colors.green, Colors.yellow,
      Colors.black, Colors.white, Colors.purple, Colors.orange,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Colors', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: colorPalette.map((color) {
            final isSelected = _controller.selectedColors.contains(color.value.toRadixString(16));
            return GestureDetector(
              onTap: () => isSelected
                  ? _controller.selectedColors.remove(color.value.toRadixString(16))
                  : _controller.selectedColors.add(color.value.toRadixString(16)),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isSelected ? const Icon(Icons.check, color: Colors.black) : null,
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Size Type', style: TextStyle(fontSize: 16)),
        Obx(() => DropdownButton<String>(
          value: _controller.sizeType.value,
          items: const [
            DropdownMenuItem(value: 'sizes', child: Text('Standard Sizes')),
            DropdownMenuItem(value: 'cm', child: Text('Centimeters')),
          ],
          onChanged: (value) => _controller.sizeType.value = value!,
        )),
        const SizedBox(height: 10),
        Obx(() {
          if (_controller.sizeType.value == 'cm') {
            return TextFormField(
              controller: _controller.sizeValuesController,
              decoration: const InputDecoration(
                labelText: 'Enter sizes in cm (comma separated)',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _controller.selectedSizes['cm'] = value.split(',').map((e) => e.trim()).toList();
              },
            );
          } else {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['S', 'M', 'L', 'XL'].map((size) {
                final isSelected = _controller.selectedSizes.containsKey(size);
                return ChoiceChip(
                  label: Text(size),
                  selected: isSelected,
                  selectedColor: Colors.yellow,
                  onSelected: (selected) => selected
                      ? _controller.selectedSizes[size] = true
                      : _controller.selectedSizes.remove(size),
                );
              }).toList(),
            );
          }
        }),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _controller.descriptionController,
      maxLines: 5,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildCreateButton() {
    return Obx(() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _controller.isLoading.value ? null : _controller.createProduct,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blue,
        ),
        child: _controller.isLoading.value
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Create Product', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    ));
  }
}
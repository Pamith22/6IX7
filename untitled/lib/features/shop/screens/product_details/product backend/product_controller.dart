import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/features/home/category_backend/category_controller.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_model.dart';
import 'package:untitled/features/shop/screens/product_details/product%20backend/product_repository.dart';
import 'package:untitled/utils/popups/loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../home/subcategory backend/sub_category_controller.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final ProductRepository _repository = ProductRepository();
  final CategoryController _categoryController = CategoryController.instance;
  final SubcategoryController _subcategoryController = SubcategoryController.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  final RxList<XFile> mediaFiles = <XFile>[].obs;
  final RxList<String> selectedColors = <String>[].obs;
  final RxMap<String, dynamic> selectedSizes = <String, dynamic>{}.obs;
  final RxString sizeType = 'sizes'.obs;
  final discountPrice = 0.0.obs;

  final titleController = TextEditingController();
  final actualPriceController = TextEditingController();
  final discountController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final sizeValuesController = TextEditingController();

  final selectedCategoryId = RxString('');
  final selectedSubcategoryId = RxString('');
  final isLoading = false.obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    actualPriceController.addListener(calculateDiscountPrice);
    discountController.addListener(calculateDiscountPrice);
    super.onInit();
  }

  Future<void> getProductById(String productId) async {
    try {
      if (productId.isEmpty) throw 'Invalid product ID';

      isLoading.value = true;
      selectedProduct.value = null;

      final product = await _repository.getProductById(productId);
      if (product == null) throw 'Product not found';

      selectedProduct.value = product;
    } on FirebaseException catch (e) {
      TLoaders.errorsnackBar(
          title: 'Database Error',
          message: e.message ?? 'Failed to fetch product'
      );
    } catch (e) {
      TLoaders.errorsnackBar(
          title: 'Error',
          message: e.toString()
      );
    } finally {
      isLoading.value = false;
    }
  }

  void calculateDiscountPrice() {
    final actualPrice = double.tryParse(actualPriceController.text) ?? 0.0;
    final discount = double.tryParse(discountController.text) ?? 0.0;
    discountPrice.value = actualPrice - (actualPrice * discount / 100);
  }

  Future<void> pickMedia() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.length + mediaFiles.length > 10) {
        throw 'Maximum 10 files allowed';
      }
      mediaFiles.addAll(pickedFiles);
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> createProduct() async {
    try {
      isLoading.value = true;

      if (titleController.text.isEmpty ||
          selectedCategoryId.value.isEmpty ||
          selectedSubcategoryId.value.isEmpty ||
          mediaFiles.isEmpty ||
          actualPriceController.text.isEmpty) {
        throw 'Please fill all required fields';
      }

      final mediaUrls = await _repository.uploadMedia(mediaFiles);

      final product = ProductModel(
        id: await _repository.generateProductId(),
        title: titleController.text.trim(),
        categoryId: selectedCategoryId.value,
        subcategoryId: selectedSubcategoryId.value,
        mediaUrls: mediaUrls,
        actualPrice: double.parse(actualPriceController.text),
        discountPercentage: double.parse(discountController.text),
        quantity: int.parse(quantityController.text),
        colors: selectedColors,
        sizes: selectedSizes,
        description: descriptionController.text.trim(),
        createdAt: DateTime.now(),
      );

      await _repository.saveProduct(product);
      resetForm();
      TLoaders.successSnackBor(title: 'Success', message: 'Product created successfully');
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsBySubcategory(String subcategoryId) async {
    try {
      isLoading.value = true;
      filteredProducts.value = await _repository.getProductsBySubcategoryId(subcategoryId);
    } catch (e) {
      TLoaders.errorsnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Stream<List<ProductModel>> streamProductsBySubcategory(String subcategoryId) {
    return _repository.getProductsBySubcategoryStream(subcategoryId)
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => ProductModel.fromSnapshot(doc))
        .toList());
  }

  void resetForm() {
    titleController.clear();
    selectedCategoryId.value = '';
    selectedSubcategoryId.value = '';
    mediaFiles.clear();
    actualPriceController.clear();
    discountController.clear();
    quantityController.clear();
    selectedColors.clear();
    selectedSizes.clear();
    descriptionController.clear();
  }
}
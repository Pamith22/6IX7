import 'package:get/get.dart';
import '../../../../home/category_backend/category_controller.dart';
import '../../../../home/category_backend/category_repository.dart';
import '../../../../home/subcategory backend/sub_category_controller.dart';
import '../../../../home/subcategory backend/sub_category_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize repositories first (if needed)
    Get.lazyPut(() => CategoryRepository());
    Get.lazyPut(() => SubcategoryRepository());

    // Initialize controllers
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => SubcategoryController());
  }
}
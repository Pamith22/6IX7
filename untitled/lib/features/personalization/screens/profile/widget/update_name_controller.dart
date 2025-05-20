
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/repositories/user/user_repository.dart';
import '../../../../../utils/Network_manager.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/popups/full_screen_loader.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/user_controller.dart';
import '../profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  final GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeName() async {
    try {
      // Add null checks here to prevent null errors
      firstName.text = userController.user.value.firstName ?? '';
      lastName.text = userController.user.value.lastName ?? '';
      print("Initial First Name: ${firstName.text}");
      print("Initial Last Name: ${lastName.text}");
    } catch (e) {
      print("Error initializing name: $e");
      // Set default empty values if there's an error
      firstName.text = '';
      lastName.text = '';
    }
  }

  Future<void> updateUserName() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorsnackBar(
            title: 'No Internet Connection',
            message: 'Please check your internet connection and try again.');
        return;
      }

      // Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Capture input values
      String firstNameValue = firstName.text.trim();
      String lastNameValue = lastName.text.trim();
      print("Updated First Name: $firstNameValue");
      print("Updated Last Name: $lastNameValue");

      // Update user's first & last name in Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstNameValue,
        'LastName': lastNameValue
      };
      await userRepository.updateSingleField(name);

      // Update the Rx User value
      userController.user.value.firstName = firstNameValue;
      userController.user.value.lastName = lastNameValue;

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBor(
          title: 'Congratulations', message: 'Your name has been updated.');

      // Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      print("Error: $e");
      TLoaders.errorsnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

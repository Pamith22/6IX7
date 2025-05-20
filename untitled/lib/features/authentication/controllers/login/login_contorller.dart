import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../Utils/constants/image_Strings.dart';
import '../../../../data/repositories/authentication_repository.dart';
import '../../../../utils/Network_manager.dart';
import '../../../../utils/constants/image_strings. dart.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginContorller extends GetxController {
  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormkey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  // @override
  // void onInit() {
  //   email.text = localStorrage.read('REMENBER_ME_EMAIL');
  //   password.text = localStorrage.read('_REMEMBER_ME_Password');
  //   super.onInit();
  // }

  /// -- Email and Password Signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loding
      TFullScreenLoader.openLoadingDialog(
          'Loging you in...', TImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation

      if (!loginFormkey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save Data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMENBER_ME_EMAIL', email.text.trim());
        localStorage.write('_REMEMBER_ME_Password', password.text.trim());
      }

      // Login user using Email and password authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorsnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  /// -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Login you in...', TImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      /// Save User Record
      await userController.saveUserRecord(userCredential);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorsnackBar(title: 'oh Snap', message: e.toString());
    }
  }
}

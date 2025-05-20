import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/product_details/product backend/App_Binding.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(GetMaterialApp(
    initialBinding: AppBindings(), // Add this line
    home: HomeScreen(),
  ));


  /// widgets binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// gex local storage

  await GetStorage.init();

  /// await splash until other items load

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);




 /// initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );





  runApp(const App());



  }




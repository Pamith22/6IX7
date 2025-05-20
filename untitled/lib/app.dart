import 'package:flutter/material.dart';
import 'package:untitled/bindings/genaral_binding.dart';
import 'package:untitled/features/authentication/screens/onboarding/onboarding.dart';
import 'package:untitled/utils/constants/colors.dart';
import 'package:untitled/utils/theme/theme.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),


      home: const Scaffold(backgroundColor: TColors.secondary,body: Center(child: CircularProgressIndicator(color: Colors.white))),

    );

  }
}

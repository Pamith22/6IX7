import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:untitled/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import '../../../../../../Utils/constants/sizes.dart';
import '../../../../../../Utils/constants/text_strings.dart';
import '../../../../../Utils/validators/validation.dart';
import '../../../controllers/signup/signup_controller.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormkey,
      child: Column(
        children: [
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            children: [
              /// first name
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (Value) =>
                      TValidator.validateEmptyText('First name', Value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: TSizes.spaceBtwInputFields,
              ),

              /// last name
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (Value) =>
                      TValidator.validateEmptyText('Last name', Value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// username
          TextFormField(
            validator: (Value) =>
                TValidator.validateEmptyText('Username', Value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// email
          TextFormField(
            validator: (Value) => TValidator.validateEmail(Value),
            controller: controller.email,
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// phone number
          TextFormField(
            validator: (Value) => TValidator.validatePhoneNumber(Value),
            controller: controller.phoneNumber,
            expands: false,
            decoration: InputDecoration(
                labelText: TTexts.phoneNo, prefixIcon: const Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// password

          Obx(
                () => TextFormField(
              controller: controller.password,
              validator: (Value) => TValidator.validatePassword(Value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye)),
              ),
            ),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          /// Terms&Condition Checkbox
          TTermsAndConditionCheckbox(dark: dark),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Sing Up   Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(TTexts.createAccount)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings. dart.dart';
import '../../Design/widget/product_customization_screen.dart';
import '../../ai_text_to_image_generator/text_to_image_generator.dart';
import 'choose_ai_screen.dart';

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Your Option')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 120),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImageButton(
                    context,
                    imagePath: TImages.selection1,
                    label: 'Design Selection',
                    destination: ProductCustomizationScreen(),
                  ),
                  SizedBox(height: 40),
                  _buildImageButton(
                    context,
                    imagePath: TImages.selection2,
                    label: 'AI Photo Generator',
                    destination: CreatePromptScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton(BuildContext context,
      {required String imagePath, required String label, required Widget destination}) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destination),
      ),
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10,
                  color: Colors.black,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
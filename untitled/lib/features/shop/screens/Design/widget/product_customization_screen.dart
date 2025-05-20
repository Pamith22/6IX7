
import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/Design/widget/editing_tool.dart';
import 'package:untitled/features/shop/screens/Design/widget/price_navigation.dart';
import 'package:untitled/features/shop/screens/Design/widget/product_screen.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/saved_editor.dart';
import 'package:untitled/features/shop/screens/Design/widget/tools/text_editor_dialog.dart';
import 'package:untitled/features/shop/screens/Design/widget/tshirt_designer.dart';
import 'package:untitled/features/shop/screens/Design/widget/view_tab.dart';
import '../../../../../utils/constants/image_strings. dart.dart';
import '../../../../../utils/constants/image_strings.dart';
import 'custom_dialog.dart';
import 'customization_icon_row.dart';
import 'file_library.dart';
import 'bottom_navigation.dart';
import 'dart:io';
import 'image_editing _tool_panel.dart';

class ProductCustomizationScreen extends StatefulWidget {
  const ProductCustomizationScreen({super.key});

  @override
  State<ProductCustomizationScreen> createState() =>
      _ProductCustomizationScreenState();
}

class _ProductCustomizationScreenState extends State<ProductCustomizationScreen> {
  final Map<String, File?> selectedImages = {
    'Front': null,
    'Back': null,
    'Left Sleeve': null,
    'Right Sleeve': null,
  };

  List<TextDesign> textDesigns = [];
  bool showEditingTools = false;
  bool showImageEditingTools = false;
  bool showCustomizationIcons = false;
  String selectedView = "Front";
  int selectedIndex = 0;

  final Map<String, String> imageMap = {
    "Front": TImages.template1,
    "Back": TImages.template1,
    "Left Sleeve": TImages.template1,
    "Right Sleeve": TImages.template1,
    "FrontSketch": TImages.template1,
    "BackSketch": TImages.template,
    "LeftSleeveSketch": TImages.template,
    "RightSleeveSketch": TImages.template,
  };

  void _handleTextAdded(TextDesign design) => setState(() => textDesigns.add(design));
  void _handleTextDeleted(int index) => setState(() => textDesigns.removeAt(index));
  void _handlePrintPressed() => print('Print button pressed');
  void _handlePrintFilePressed() => print('Print file pressed');
  void _handleBackPressed() => print('Back pressed');

  void _handleNextPressed(BuildContext context) {
    if (selectedImages[selectedView] != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) => const SummaryBottomSheet(),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      );
    }
  }

  Future<void> pickImage() async {
    final File? selectedFile = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FileLibraryScreen()),
    );

    if (selectedFile != null && mounted) {
      setState(() {
        selectedImages[selectedView] = selectedFile;
        showCustomizationIcons = true;
        showImageEditingTools = true;
      });
    }
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 1) {
        final hasImage = selectedImages[selectedView] != null;
        showImageEditingTools = hasImage;
        showEditingTools = !hasImage;
      } else {
        showEditingTools = false;
        showImageEditingTools = false;
      }
    });
  }

  void _handleImageTapped() => setState(() => showImageEditingTools = true);

  Widget _buildBottomPanel() {
    final currentImage = selectedImages[selectedView];

    if (currentImage != null && showImageEditingTools) {
      return ImageEditingToolsPanel(
        designImage: currentImage,
        onBackPressed: () => setState(() {
          showImageEditingTools = false;
          selectedIndex = 0;
        }),
        onAddDesignPressed: () => setState(() {
          showImageEditingTools = false;
          showEditingTools = true;
        }),
      );
    } else if (showEditingTools) {
      return EditingToolsPanel(
        context: context,
        onBackPressed: () => setState(() {
          showEditingTools = false;
          selectedIndex = 0;
        }),
        onUploadPressed: pickImage,
        onTextPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => TextEditorDialog(onSave: _handleTextAdded),
        ),
        onSavePressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const SavedDesignsDialog(),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        );
      }
        return BottomNavBar(
        onTabTapped: onTabTapped,
        selectedIndex: selectedIndex,
        onProductTab: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const ProductScreen(),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Customization")),
      body: Column(
        children: [
          const SizedBox(height: 30),
          if (showCustomizationIcons)
            CustomizationIconsRow(
              onPrintPressed: _handlePrintFilePressed,
              onBackPressed: _handleBackPressed,
            ),
          ViewSelectionTabs(
            selectedView: selectedView,
            onTabSelected: (view) => setState(() {
              selectedView = view;
              final hasImage = selectedImages[view] != null;
              showImageEditingTools = hasImage;
              showEditingTools = !hasImage;
            }),
            onPrintPressed: _handlePrintPressed,
            imageMap: imageMap,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: TShirtDesigner(
                tshirtImage: imageMap[selectedView]!,
                sketchImage: imageMap["${selectedView.replaceAll(' ', '')}Sketch"] ?? TImages.template,
                selectedImage: selectedImages[selectedView],
                onImageSelected: pickImage,
                onImageDeleted: () => setState(() {
                  selectedImages[selectedView] = null;
                  showCustomizationIcons = false;
                  showImageEditingTools = false;
                }),
                onImageTapped: _handleImageTapped,
                textDesigns: textDesigns,
                onTextAdded: _handleTextAdded,
                onTextDeleted: _handleTextDeleted,
              ),
            ),
          ),
          const SizedBox(height: 20),
          PriceNavigation(onPressed: () => _handleNextPressed(context)),
        ],
      ),
      bottomNavigationBar: _buildBottomPanel(),
    );
  }
}

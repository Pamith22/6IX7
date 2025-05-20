import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/shop/screens/selection%20screen/widget/selection_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Selector',
      home: SelectionScreen(), // Set initial screen directly
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String categoryId;
  final String subcategoryId;
  final List<String> mediaUrls;
  final double actualPrice;
  final double discountPercentage;
  final int quantity;
  final List<String> colors;
  final Map<String, dynamic> sizes;
  final String description;
  final DateTime createdAt;


  ProductModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.subcategoryId,
    required this.mediaUrls,
    required this.actualPrice,
    required this.discountPercentage,
    required this.quantity,
    required this.colors,
    required this.sizes,
    required this.description,
    required this.createdAt,
  });

  factory ProductModel.empty() => ProductModel(
    id: '',
    title: '',
    categoryId: '',
    subcategoryId: '',
    mediaUrls: [],
    actualPrice: 0.0,
    discountPercentage: 0.0,
    quantity: 0,
    colors: [],
    sizes: {},
    description: '',
    createdAt: DateTime.now(),
  );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'categoryId': categoryId,
      'subcategoryId': subcategoryId,
      'mediaUrls': mediaUrls,
      'actualPrice': actualPrice,
      'discountPercentage': discountPercentage,
      'quantity': quantity,
      'colors': colors,
      'sizes': sizes,
      'description': description,
      'createdAt': createdAt.toUtc(),
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      id: snapshot.id, // Correct document ID handling
      title: data['title'] ?? '',
      categoryId: data['categoryId'] ?? '',
      subcategoryId: data['subcategoryId'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      actualPrice: (data['actualPrice'] ?? 0.0).toDouble(),
      discountPercentage: (data['discountPercentage'] ?? 0.0).toDouble(),
      quantity: data['quantity'] ?? 0,
      colors: List<String>.from(data['colors'] ?? []),
      sizes: Map<String, dynamic>.from(data['sizes'] ?? {}),
      description: data['description'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
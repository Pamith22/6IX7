// subcategory_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryModel {
  final String id;
  final String name;
  final String categoryId;
  final DateTime createdAt;

  SubcategoryModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'createdAt': createdAt.toUtc(),
    };
  }

  factory SubcategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return SubcategoryModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      categoryId: data['categoryId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
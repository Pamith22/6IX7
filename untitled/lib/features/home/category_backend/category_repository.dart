// category_repository.dart
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> generateCategoryId() async {
    try {
      final query = await _db.collection('categories')
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return '001';

      final lastId = query.docs.first['id'];
      final newIdNum = int.parse(lastId) + 1;
      return newIdNum.toString().padLeft(3, '0');
    } catch (e) {
      throw 'Error generating category ID: $e';
    }
  }

  Future<void> saveCategory(CategoryModel category) async {
    try {
      await _db.collection('categories').doc(category.id).set(category.toJson());
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error saving category: $e';
    }
  }

  Future<String> uploadCategoryImage(String path, File image) async {
    try {
      final ref = _storage.ref(path).child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw 'Storage Error: ${e.code}';
    } catch (e) {
      throw 'Error uploading image: $e';
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final querySnapshot = await _db.collection('categories').get();
      return querySnapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error fetching categories: $e';
    }
  }
}
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'product_model.dart';

class ProductRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> generateProductId() async {
    final query = await _db.collection('products')
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return '001';
    final lastId = query.docs.first['id'];
    final newIdNum = int.parse(lastId) + 1;
    return newIdNum.toString().padLeft(3, '0');
  }

  Future<List<String>> uploadMedia(List<XFile> files) async {
    try {
      final List<String> urls = [];
      for (final file in files) {
        final ref = _storage.ref().child('products/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(File(file.path));
        urls.add(await ref.getDownloadURL());
      }
      return urls;
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error uploading media: $e';
    }
  }

  Future<void> saveProduct(ProductModel product) async {
    try {
      await _db.collection('products').doc(product.id).set(product.toJson());
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error saving product: $e';
    }
  }

  Future<ProductModel> getProductById(String productId) async {
    try {
      final doc = await _db.collection('products').doc(productId).get();
      if (!doc.exists) throw 'Product not found';
      return ProductModel.fromSnapshot(doc);
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error fetching product: $e';
    }
  }

  Future<List<ProductModel>> getProductsBySubcategoryId(String subcategoryId) async {
    try {
      final querySnapshot = await _db.collection('products')
          .where('subcategoryId', isEqualTo: subcategoryId)
          .get();
      return querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error fetching products: $e';
    }
  }

  Stream<QuerySnapshot> getProductsBySubcategoryStream(String subcategoryId) {
    return _db.collection('products')
        .where('subcategoryId', isEqualTo: subcategoryId)
        .snapshots();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/features/home/subcategory%20backend/sub_category_model.dart';

class SubcategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> generateSubcategoryId() async {
    try {
      final query = await _db.collection('subcategories')
          .orderBy('id', descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return '001';
      final lastId = query.docs.first['id'];
      final newIdNum = int.parse(lastId) + 1;
      return newIdNum.toString().padLeft(3, '0');
    } catch (e) {
      throw 'Error generating subcategory ID: $e';
    }
  }

  Future<void> saveSubcategory(SubcategoryModel subcategory) async {
    try {
      await _db.collection('subcategories').doc(subcategory.id).set(subcategory.toJson());
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error saving subcategory: $e';
    }
  }

  Future<List<SubcategoryModel>> getSubcategoriesByCategoryId(String categoryId) async {
    try {
      final querySnapshot = await _db.collection('subcategories')
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return querySnapshot.docs.map((doc) => SubcategoryModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Error fetching subcategories: $e';
    }
  }
}
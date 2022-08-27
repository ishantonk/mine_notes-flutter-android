import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  // * Add a category to the database

  void createCategory({
    required String name,
    required int colorId,
    required int iconId,
  }) async {
    emit(CategoryCreateLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Categories');

      // Extracting the user id from the current user.
      final userId = FirebaseAuth.instance.currentUser?.uid;

      // Checking if the name is empty.
      if (name.isNotEmpty) {
        // Creating a new category.
        final Map<String, Object?> category = {
          'name': name.trim(),
          'colorId': colorId,
          'iconId': iconId,
          'createdAt': DateTime.now(),
          'userId': userId,
        };

        // Adding the category to the categories collection.
        await collection.add(category);
        emit(CategoryCreateDone(category));
      } else {
        // If the name is empty, then emit the error state.
        emit(CategoryCreateError('The name of the category cannot be empty.'));
      }
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(CategoryCreateError(e.toString()));
    }
  }

  // * Update a category in the database.

  void updateCategory({
    required String name,
    required int colorId,
    required int iconId,
    required String categoryId,
  }) async {
    emit(CategoryUpdateLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Categories');

      // Checking if the name is empty.
      if (name.isNotEmpty) {
        // Updating the category.
        final Map<String, Object?> category = {
          'name': name.trim(),
          'colorId': colorId,
          'iconId': iconId,
        };

        // Updating the category in the categories collection.
        await collection.doc(categoryId).update(category);
        emit(CategoryUpdateDone(category));
      } else {
        // If the name is empty, then emit the error state.
        emit(CategoryUpdateError('The name of the category cannot be empty.'));
      }
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(CategoryUpdateError(e.toString()));
    }
  }

  // * Delete a category from the database.

  void deleteCategory({required String categoryId}) async {
    emit(CategoryDeleteLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Categories');

      // Deleting the category from the categories collection.
      await collection.doc(categoryId).delete();
      emit(CategoryDeleteDone());
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(CategoryDeleteError(e.toString()));
    }
  }
}

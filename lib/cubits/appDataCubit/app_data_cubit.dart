import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_data_state.dart';

class AppDataCubit extends Cubit<AppDataState> {
  // Get notes collection for the current user.
  final notes = FirebaseFirestore.instance
      .collection('Notes')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

  // Get categories collection for the current user.
  final categories = FirebaseFirestore.instance
      .collection('Categories')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid);

  // Initial state.
  AppDataCubit() : super(AppDataInitial());

  // Retrieve search results.
  void retrieveSearchResults({required String query}) async {
    emit(AppDataLoading());

    if (query.isNotEmpty) {
      try {
        // Get all the notes which match the query.
        final QuerySnapshot notesQuery = await notes
            .where('title',
                isGreaterThanOrEqualTo: query, isLessThanOrEqualTo: query)
            .get();

        // Get all the categories which match the query.
        final QuerySnapshot categoriesQuery = await categories
            .where('name',
                isGreaterThanOrEqualTo: query, isLessThanOrEqualTo: query)
            .get();

        // Get all the notes which match the query.
        final List<QueryDocumentSnapshot<Object?>> listOfNotes =
            notesQuery.docs;

        // Get all the categories which match the query.
        final List<QueryDocumentSnapshot<Object?>> listOfCategories =
            categoriesQuery.docs;

        // Creating a list of search results.
        final List<Map<String, Object?>> searchResults = [];

        // Adding the notes to the search results.
        for (var note in listOfNotes) {
          searchResults.add({
            'type': 'note',
            'id': note.id,
            'title': note['title'],
            'content': note['content'],
            'colorId': note['colorId'],
            'iconId': note['iconId'],
            'categoryId': note['categoryId'],
            'userId': note['userId'],
          });
        }

        // Adding the categories to the search results.
        for (var category in listOfCategories) {
          searchResults.add({
            'type': 'category',
            'id': category.id,
            'name': category['name'],
            'colorId': category['colorId'],
            'iconId': category['iconId'],
            'userId': category['userId'],
          });
        }

        // Checking if the search results list is empty.
        if (searchResults.isNotEmpty) {
          // Emitting the search results state.
          emit(AppDataSearchResults(searchResults));
        } else {
          // Emitting the error state.
          emit(AppDataError('No results found.'));
        }
      } catch (e) {
        // If something goes wrong, then emit the error state.
        emit(AppDataError(e.toString()));
      }
    }
  }
}

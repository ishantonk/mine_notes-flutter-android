part of 'app_data_cubit.dart';

@immutable
abstract class AppDataState {}

// Initial state.
class AppDataInitial extends AppDataState {}

// State for loading the data.
class AppDataLoading extends AppDataState {}

// State for when a note is created.
class AppDataNoteCreated extends AppDataState {
  final Map<String, dynamic> noteData;

  AppDataNoteCreated(this.noteData);
}

// State for when a note is update.
class AppDataNoteUpdated extends AppDataState {
  final Map<String, dynamic> noteData;

  AppDataNoteUpdated(this.noteData);
}

// State for retrieving the list of notes.
class AppDataNotes extends AppDataState {
  final List<QueryDocumentSnapshot<Object?>> listOfNotes;

  AppDataNotes(this.listOfNotes);
}

// State for retrieve a note.
class AppDataNote extends AppDataState {
  final DocumentSnapshot<Object?> noteData;

  AppDataNote(this.noteData);
}

// State for when a note is deleted.
class AppDataNoteDeleted extends AppDataState {}

// State for when a category is created.
class AppDataCategoryCreated extends AppDataState {
  final Map<String, dynamic> categoryData;

  AppDataCategoryCreated(this.categoryData);
}

// State for when a category is edited.
class AppDataCategoryUpdated extends AppDataState {
  final Map<String, dynamic> categoryData;

  AppDataCategoryUpdated(this.categoryData);
}

// State for retrieving the list of categories.
class AppDataCategories extends AppDataState {
  final List<QueryDocumentSnapshot<Object?>> listOfCategories;

  AppDataCategories(this.listOfCategories);
}

// State for retrieve a category.
class AppDataCategory extends AppDataState {
  final DocumentSnapshot<Object?> categoryData;

  AppDataCategory(this.categoryData);
}

// State for when a category is deleted.
class AppDataCategoryDeleted extends AppDataState {}

// State for when an error occurs.
class AppDataError extends AppDataState {
  final String message;

  AppDataError(this.message);
}

// State for when searching.
class AppDataSearchResults extends AppDataState {
  final List<Map<String, Object?>> searchResult;

  AppDataSearchResults(this.searchResult);
}

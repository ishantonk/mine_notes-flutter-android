part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

// * CATEGORY-CREATE.

class CategoryCreateLoading extends CategoryState {}

class CategoryCreateDone extends CategoryState {
  final Map<String, Object?> category;

  CategoryCreateDone(this.category);
}

class CategoryCreateError extends CategoryState {
  final String message;

  CategoryCreateError(this.message);
}

// * CATEGORY-UPDATE.
class CategoryUpdateLoading extends CategoryState {}

class CategoryUpdateDone extends CategoryState {
  final Map<String, Object?> category;

  CategoryUpdateDone(this.category);
}

class CategoryUpdateError extends CategoryState {
  final String message;

  CategoryUpdateError(this.message);
}

// * CATEGORY-DELETE.

class CategoryDeleteLoading extends CategoryState {}

class CategoryDeleteDone extends CategoryState {}

class CategoryDeleteError extends CategoryState {
  final String message;

  CategoryDeleteError(this.message);
}

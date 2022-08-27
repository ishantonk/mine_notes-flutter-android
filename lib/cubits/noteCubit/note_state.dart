part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

// * NOTE-CREATE.

class NoteCreateLoading extends NoteState {}

class NoteCreateDone extends NoteState {
  final Map<String, Object?> note;

  NoteCreateDone(this.note);
}

class NoteCreateError extends NoteState {
  final String message;

  NoteCreateError(this.message);
}

// * NOTE-UPDATE.

class NoteUpdateLoading extends NoteState {}

class NoteUpdateDone extends NoteState {
  final Map<String, Object?> note;

  NoteUpdateDone(this.note);
}

class NoteUpdateError extends NoteState {
  final String message;

  NoteUpdateError(this.message);
}

// * NOTE-DUPLICATE.

class NoteDuplicateLoading extends NoteState {}

class NoteDuplicateDone extends NoteState {
  final Map<String, Object?> note;

  NoteDuplicateDone(this.note);
}

class NoteDuplicateError extends NoteState {
  final String message;

  NoteDuplicateError(this.message);
}

// * NOTE-DELETE.

class NoteDeleteLoading extends NoteState {}

class NoteDeleteDone extends NoteState {}

class NoteDeleteError extends NoteState {
  final String message;

  NoteDeleteError(this.message);
}

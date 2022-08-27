import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  // * Add a note to the database.

  void createNote({
    required String title,
    required String content,
    required String categoryId,
    required int colorId,
    required bool isArchived,
    required bool isPinned,
  }) async {
    emit(NoteCreateLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Notes');

      // Extracting the user id from the current user.
      final userId = FirebaseAuth.instance.currentUser?.uid;

      // Checking if the content is empty.
      if (content.isNotEmpty) {
        // Check if the title is empty.
        if (title.isEmpty) {
          // If the title is empty, then set the title to untitled.
          title = 'Untitled';
        }

        // Creating a new note.
        final Map<String, Object?> note = {
          'title': title.trim(),
          'content': content,
          'categoryId': categoryId,
          'colorId': colorId,
          'dateCreated': DateTime.now(),
          'dateEdited': DateTime.now(),
          'isArchived': isArchived,
          'isPinned': isPinned,
          'userId': userId,
        };

        // Adding the note to the notes collection.
        await collection.add(note);
        emit(NoteCreateDone(note));
      } else {
        // If the content is empty, then emit the error state.
        emit(NoteCreateError('The content of the note cannot be empty.'));
      }
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(NoteCreateError(e.toString()));
    }
  }

  // * Update a note in the database.

  void updateNote({
    required String title,
    required String content,
    required String categoryId,
    required int colorId,
    required bool isArchived,
    required bool isPinned,
    required String noteId,
  }) async {
    emit(NoteUpdateLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Notes');

      // Checking if the content is empty.
      if (content.isNotEmpty) {
        // Check if the title is empty.
        if (title.isEmpty) {
          // If the title is empty, then set the title to untitled.
          title = 'Untitled';
        }

        // Updating the note.
        final Map<String, Object?> note = {
          'title': title.trim(),
          'content': content,
          'categoryId': categoryId,
          'colorId': colorId,
          'dateEdited': DateTime.now(),
          'isArchived': isArchived,
          'isPinned': isPinned,
        };

        // Updating the note in the notes collection.
        await collection.doc(noteId).update(note);
        emit(NoteUpdateDone(note));
      } else {
        // If the content is empty, then emit the error state.
        emit(NoteUpdateError('The content of the note cannot be empty.'));
      }
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(NoteUpdateError(e.toString()));
    }
  }

  // * Duplicate a note in the database.

  void duplicateNote({required String noteId}) async {
    emit(NoteDuplicateLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Notes');

      // Getting the note from the notes collection for the current user.
      final DocumentSnapshot noteDoc = await collection.doc(noteId).get();

      // Checking if the note is exists.
      if (noteDoc.exists) {
        // If the note exists, then emit the note state.

        // Creating a new note.
        final Map<String, Object?> note = {
          'title': noteDoc['title'],
          'content': noteDoc['content'],
          'categoryId': noteDoc['categoryId'],
          'colorId': noteDoc['colorId'],
          'dateCreated': DateTime.now(),
          'dateEdited': DateTime.now(),
          'isArchived': noteDoc['isArchived'],
          'isPinned': noteDoc['isPinned'],
          'userId': noteDoc['userId'],
        };

        // Adding the note to the notes collection.
        await collection.add(note);
        emit(NoteDuplicateDone(note));
      } else {
        // If the note not exist, then emit the error state.
        emit(NoteDuplicateError('No note found.'));
      }
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(NoteDuplicateError(e.toString()));
    }
  }

  // * Delete a note from the database.

  void deleteNote({required String noteId}) async {
    emit(NoteDeleteLoading());

    try {
      // Get collection reference.
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('Notes');

      // Deleting the note from the notes collection.
      await collection.doc(noteId).delete();
      emit(NoteDeleteDone());
    } catch (e) {
      // If something goes wrong, then emit the error state.
      emit(NoteDeleteError(e.toString()));
    }
  }
}

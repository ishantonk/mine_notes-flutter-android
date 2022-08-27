import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NotesCardList extends StatelessWidget {
  const NotesCardList({Key? key, this.forArchive}) : super(key: key);
  final bool? forArchive;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final stream = forArchive == true
        // Get all notes that are archived.
        ? FirebaseFirestore.instance
            .collection('Notes')
            .where('userId', isEqualTo: userId)
            .where('isArchived', isEqualTo: true)
            // .orderBy('isPinned', descending: true)
            .snapshots()
        // Get all notes.
        : FirebaseFirestore.instance
            .collection('Notes')
            .where('userId', isEqualTo: userId)
            .where('isArchived', isEqualTo: false)
            .snapshots();

    // Showing list of notes.
    return Expanded(
      child: StreamBuilder(
        stream: stream,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Showing loading indicator.
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length < 1) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    forArchive == true
                        ? 'assets/images/archive_empty.png'
                        : 'assets/images/notes_empty.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24.0),
                  const Text('No note present.')
                ],
              );
            } else if (snapshot.hasData) {
              // Showing list of notes.
              return MasonryGridView(
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                children: snapshot.data.docs.map<Widget>(
                  (doc) {
                    return NoteCard(
                      note: doc,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'edit_note',
                          arguments: doc,
                        );
                      },
                    );
                  },
                ).toList(),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}

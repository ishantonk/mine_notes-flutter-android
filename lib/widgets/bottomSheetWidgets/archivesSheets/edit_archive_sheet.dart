import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/sheet_holder_widget.dart';

class EditArchiveSheet extends StatelessWidget {
  const EditArchiveSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final stream = FirebaseFirestore.instance
        .collection('Notes')
        .where('userId', isEqualTo: userId)
        .snapshots();

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHolderWidget(),

          const SizedBox(height: 16),

          // Header row.
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title.
                const Text(
                  'Archives',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Close button.
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          // Archive list.
          Expanded(
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
                          'assets/images/void.png',
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24.0),
                        const Text('No note present.')
                      ],
                    );
                  } else if (snapshot.hasData) {
                    // Showing list of notes.
                    return ListView(
                      children: snapshot.data.docs.map<Widget>(
                        (doc) {
                          return _listItemNote(context, doc);
                        },
                      ).toList(),
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for building each list item.
  Container _listItemNote(BuildContext context, DocumentSnapshot doc) {
    return Container(
      // Margin between list items.
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: doc['isArchived']
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.white,
      ),
      child: ListTile(
        // Title.
        title: Text(
          doc['title'].toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Subtitle.
        subtitle: Text(
          doc['content'].toString(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        // Trailing icon.
        trailing: Icon(
          doc['isPinned'] == true ? Icons.star : Icons.star_border,
          color: Colors.yellowAccent,
        ),

        // OnTap.
        onTap: () {
          doc.reference.update({
            'isArchived': doc['isArchived'] == true ? false : true,
          });
        },
      ),
    );
  }
}

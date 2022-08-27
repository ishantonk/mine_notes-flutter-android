import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mine_notes/utils/themes.dart';
import 'package:mine_notes/widgets/widgets.dart';

class CategoryNoteSheet extends StatelessWidget {
  const CategoryNoteSheet(
      {Key? key,
      required this.currentCategoryId,
      required this.getChangedCategoryId})
      : super(key: key);
  final String currentCategoryId;
  final Function getChangedCategoryId;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final stream = FirebaseFirestore.instance
        .collection('Categories')
        .where('userId', isEqualTo: userId)
        .snapshots();

    // Widget for the category list.
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // Make sheet size to be equal to the content size.
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sheet holder.
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
                  'Choose category',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Close button.
                IconButton(
                  alignment: Alignment.centerRight,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: StreamBuilder(
              stream: stream,
              initialData: null,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Showing loading indicator.
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data.docs.map<Widget>((doc) {
                        return _categoryListItem(doc, context);
                      }).toList(),
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

  Container _categoryListItem(doc, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: Icon(ListIcons.categoriesIcons[doc['iconId']]),
        title: Text(doc['name']),
        tileColor: doc.id == currentCategoryId
            ? SliderColors.categoriesColors[doc['colorId']].withOpacity(0.35)
            : Theme.of(context).listTileTheme.tileColor,
        onTap: () {
          if (doc.id != currentCategoryId) {
            getChangedCategoryId(doc.id);
            Navigator.pop(context);
          } else {
            // Remove category.
            getChangedCategoryId(' ');
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

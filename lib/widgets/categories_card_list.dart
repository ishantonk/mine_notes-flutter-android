import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/widgets.dart';

class CategoriesCardList extends StatelessWidget {
  const CategoriesCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final stream = FirebaseFirestore.instance
        .collection('Categories')
        .where('userId', isEqualTo: userId)
        .snapshots();

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isEmpty ?? true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/folder.png',
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 24.0),
                  const Text('No category present.')
                ],
              );
            } else {
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                ),
                children: snapshot.data!.docs
                    .map(
                      (category) => CategoryCard(
                        onTap: () {
                          showModalBottomSheet(
                            enableDrag: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => OpenCategorySheet(
                              categoryDoc: category,
                            ),
                          );
                        },
                        doc: category,
                      ),
                    )
                    .toList(),
              );
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

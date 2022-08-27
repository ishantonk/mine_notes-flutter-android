import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/widgets/widgets.dart';

class OptionCategorySheet extends StatelessWidget {
  const OptionCategorySheet({Key? key, required this.doc}) : super(key: key);
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    void _onEdit() {
      Navigator.pop(context);
      showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => EditCategorySheet(categoryDoc: doc),
      );
    }

    void _onDelete() {
      BlocProvider.of<CategoryCubit>(context)
          .deleteCategory(categoryId: doc.id);
      // Navigate back to the home screen.
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category has been Deleted successfully!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // Make sheet size to be equal to the content size.
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sheet holder.
          const SheetHolderWidget(),

          const SizedBox(height: 8),
          // Edit tile.
          ListTile(
            leading: const Icon(Iconsax.edit),
            title: const Text('Edit'),
            onTap: () => _onEdit(),
          ),

          const SizedBox(height: 8),
          // Delete tile.
          BlocListener<CategoryCubit, CategoryState>(
            listener: (context, state) {
              // If the category is deleted, close the sheet.
              if (state is CategoryDeleteDone) {
                // Show a snackbar with success message.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Category has been Deleted successfully!'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
                // Navigate to previous page.
                Navigator.pop(context);
              } else if (state is CategoryDeleteError) {
                // Show a snackbar with error message.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: ListTile(
              leading: const Icon(Iconsax.trash),
              title: const Text('Delete'),
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              onTap: () => {
                showModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) => DeleteBottomSheet(
                    onDelete: _onDelete,
                    docType: 'Note',
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

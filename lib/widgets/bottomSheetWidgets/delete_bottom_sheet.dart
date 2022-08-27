import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/widgets/widgets.dart';

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet(
      {Key? key, required this.onDelete, required this.docType})
      : super(key: key);
  final Function onDelete;
  final String docType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // * Padding is used when keyboard is shown.
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Make sheet size to be equal to the content size.
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sheet holder.
            const SheetHolderWidget(),

            const SizedBox(height: 8),

            // Title.
            Text(
              'Delete ${docType.toLowerCase()}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),
            // Subtitle.
            Text(
              'Are you sure you want to delete this ${docType.toLowerCase()}?',
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Cancel button.
                ButtonWidget(
                  icon: Icons.close,
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
                // Delete button.
                ButtonWidget(
                  icon: Iconsax.trash,
                  label: 'Delete',
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => {
                    onDelete(),
                    Navigator.pop(context),
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

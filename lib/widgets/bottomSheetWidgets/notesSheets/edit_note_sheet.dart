import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

class EditNoteSheet extends StatelessWidget {
  const EditNoteSheet({
    Key? key,
    required this.categoryId,
    required this.colorId,
    required this.isPinned,
    required this.isArchived,
    required this.onCategoryIdChanged,
    required this.onColorIdChanged,
    required this.onIsPinnedChanged,
    required this.onIsArchivedChanged,
    required this.onShareTap,
    required this.onDuplicateTap,
    required this.onDeleteTap,
  }) : super(key: key);
  final String categoryId;
  final int colorId;
  final bool isPinned;
  final bool isArchived;
  final Function onCategoryIdChanged;
  final Function onColorIdChanged;
  final Function onIsPinnedChanged;
  final Function onIsArchivedChanged;
  final Function onShareTap;
  final Function onDuplicateTap;
  final Function onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          // If the note is deleted, close the sheet.
          if (state is NoteDeleteDone) {
            // Show a snackbar with success message.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Note has been Deleted successfully!'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            // Navigate to home.
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is NoteDeleteError) {
            // Show a snackbar with error message.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }

          // If the note is duplicate, close the sheet.
          if (state is NoteDuplicateDone) {
            // Show a snackbar with success message.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Note has been Duplicated successfully!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );
            // Navigate to home.
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is NoteDuplicateError) {
            // Show a snackbar with error message.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: Column(
          // Make sheet size to be equal to the content size.
          mainAxisSize: MainAxisSize.min,
          children: [
            const SheetHolderWidget(),

            const SizedBox(height: 8),
            // Color picker.
            ColorSliderWidget(
              title: 'Choose note color',
              colorsList: SliderColors.notesColors,
              currentColorId: colorId,
              getChangedColorId: onColorIdChanged,
            ),

            const SizedBox(height: 8),
            // Switch for pinning.
            SwitchListTileWidget(
              icon: Iconsax.clipboard,
              title: 'Pin',
              switchVal: isPinned,
              onChangeVal: onIsPinnedChanged,
            ),

            const SizedBox(height: 8),
            // Switch for archiving.
            SwitchListTileWidget(
              icon: Iconsax.archive,
              title: 'Archive',
              switchVal: isArchived,
              onChangeVal: onIsArchivedChanged,
            ),

            const SizedBox(height: 8),
            // Category picker.
            ListTile(
              leading: const Icon(Iconsax.category),
              title: const Text('Category'),
              trailing: const Icon(Iconsax.arrow_right_3),
              onTap: () {
                showModalBottomSheet(
                  enableDrag: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return CategoryNoteSheet(
                      currentCategoryId: categoryId,
                      getChangedCategoryId: onCategoryIdChanged,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 8),
            // Duplicate tile.
            ListTile(
              leading: const Icon(Iconsax.copy),
              title: const Text('Duplicate'),
              onTap: () => onDuplicateTap(),
            ),

            const SizedBox(height: 8),
            // Share tile.
            ListTile(
              leading: const Icon(Iconsax.share),
              title: const Text('Share'),
              onTap: () => onShareTap(),
            ),

            const SizedBox(height: 8),
            // Delete tile.
            ListTile(
              leading: const Icon(Iconsax.trash),
              title: const Text('Delete'),
              iconColor: Theme.of(context).colorScheme.error,
              textColor: Theme.of(context).colorScheme.error,
              onTap: () => {
                showModalBottomSheet(
                  enableDrag: true,
                  context: context,
                  builder: (context) => DeleteBottomSheet(
                    onDelete: onDeleteTap,
                    docType: 'Note',
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

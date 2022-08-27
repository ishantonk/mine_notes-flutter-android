import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

// On long press, show options sheet.
class OptionNoteSheet extends StatelessWidget {
  const OptionNoteSheet({Key? key, required this.note}) : super(key: key);
  final DocumentSnapshot note;

  @override
  Widget build(BuildContext context) {
    final DocumentReference noteRef =
        FirebaseFirestore.instance.collection('Notes').doc(note.id);

    void _updateIsPinned(bool isPinned) {
      noteRef.update({'isPinned': isPinned});
    }

    void _updateIsArchived(bool isArchived) {
      noteRef.update({'isArchived': isArchived});
    }

    void _updateColorId(int colorId) {
      noteRef.update({'colorId': colorId});
    }

    void _onShare() {
      // TODO: Share the note implementation.
    }

    void _onDelete() {
      // Perform delete operation.
      BlocProvider.of<NoteCubit>(context).deleteNote(noteId: note.id);
      // Navigate back to the home screen.
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Note has been Deleted successfully!'),
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
          // Color picker.
          ColorSliderWidget(
            title: 'Choose note color',
            colorsList: SliderColors.notesColors,
            currentColorId: note['colorId'],
            getChangedColorId: _updateColorId,
          ),

          const SizedBox(height: 8),
          // Switch for pinning.
          SwitchListTileWidget(
            icon: Iconsax.clipboard,
            title: 'Pin',
            switchVal: note['isPinned'],
            onChangeVal: _updateIsPinned,
          ),

          const SizedBox(height: 8),
          // Switch for archiving.
          SwitchListTileWidget(
            icon: Iconsax.archive,
            title: 'Archive',
            switchVal: note['isArchived'],
            onChangeVal: _updateIsArchived,
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
                    currentCategoryId: note['categoryId'],
                    getChangedCategoryId: (categoryId) {
                      noteRef.update({'categoryId': categoryId});
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 8),
          // Share tile.
          ListTile(
            leading: const Icon(Iconsax.share),
            title: const Text('Share'),
            onTap: () => _onShare(),
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
                  onDelete: _onDelete,
                  docType: 'Note',
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}

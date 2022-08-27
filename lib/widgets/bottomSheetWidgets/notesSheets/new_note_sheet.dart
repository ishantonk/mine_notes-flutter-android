import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NewNoteSheet extends StatelessWidget {
  const NewNoteSheet({
    Key? key,
    required this.categoryId,
    required this.colorId,
    required this.isPinned,
    required this.isArchived,
    required this.onCategoryIdChanged,
    required this.onColorIdChanged,
    required this.onIsPinnedChanged,
    required this.onIsArchivedChanged,
  }) : super(key: key);
  final String categoryId;
  final int colorId;
  final bool isPinned;
  final bool isArchived;
  final Function onCategoryIdChanged;
  final Function onColorIdChanged;
  final Function onIsPinnedChanged;
  final Function onIsArchivedChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
        ],
      ),
    );
  }
}

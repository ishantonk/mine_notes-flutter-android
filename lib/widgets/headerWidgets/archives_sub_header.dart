import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/widgets/widgets.dart';

class ArchivesSubHeader extends StatelessWidget {
  const ArchivesSubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Add Archive',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              isScrollControlled: true,
              context: context,
              builder: (context) => EditArchiveSheet(),
            );
          },
          icon: const Icon(Iconsax.archive_add),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

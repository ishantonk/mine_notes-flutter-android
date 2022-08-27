import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/widgets/widgets.dart';

class CategoriesSubHeader extends StatelessWidget {
  const CategoriesSubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Add category',
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
              builder: (context) => const NewCategorySheet(),
            );
          },
          icon: const Icon(Iconsax.folder_add),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

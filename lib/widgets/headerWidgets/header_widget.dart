import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/widgets/headerWidgets/archives_sub_header.dart';
import 'package:mine_notes/widgets/headerWidgets/categories_sub_header.dart';
import 'package:mine_notes/widgets/headerWidgets/notes_sub_header.dart';
import 'package:mine_notes/widgets/headerWidgets/settings_sub_header.dart';
import 'package:mine_notes/widgets/widgets.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required this.pageIndex}) : super(key: key);
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    // List of header icons.
    final List<IconData> icons = [
      Iconsax.note,
      Iconsax.category_2,
      Iconsax.archive,
      Iconsax.setting_2,
    ];

    // List of header titles.
    final List<String> titles = [
      'Notes',
      'Categories',
      'Archive',
      'Settings',
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              // --Header-icon--
              Icon(
                icons[pageIndex],
                color: Colors.black,
                size: 40,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.24),
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              // --Page-heading-text--
              Text(
                titles[pageIndex],
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              // --Search-icon-button--
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const SearchBottomSheet(),
                  );
                },
                icon: const Icon(Iconsax.search_normal),
                alignment: Alignment.centerRight,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // --Sub-heading--
          if (pageIndex == 0) const NotesSubHeader(),
          if (pageIndex == 1) const CategoriesSubHeader(),
          if (pageIndex == 2) const ArchivesSubHeader(),
          if (pageIndex == 3) const SettingsSubHeader(),
        ],
      ),
    );
  }
}

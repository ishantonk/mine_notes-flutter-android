import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mine_notes/utils/themes.dart';
import 'package:mine_notes/widgets/bottomSheetWidgets/bottom_sheet_widgets.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.doc, this.onTap})
      : super(key: key);
  final QueryDocumentSnapshot doc;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        showModalBottomSheet(
          enableDrag: true,
          isScrollControlled: true,
          context: context,
          builder: (context) => OptionCategorySheet(
            doc: doc,
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        borderOnForeground: true,
        color: SliderColors.categoriesColors[doc['colorId']].withAlpha(75),
        shadowColor:
            SliderColors.categoriesColors[doc['colorId']].withOpacity(0.1),
        surfaceTintColor:
            SliderColors.categoriesColors[doc['colorId']].withOpacity(0.1),
        elevation: 0,
        key: ValueKey(doc.id),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                ListIcons.categoriesIcons[doc['iconId']],
                color: SliderColors.categoriesColors[doc['colorId']],
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                doc['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: SliderColors.categoriesColors[doc['colorId']]
                          .withOpacity(0.1),
                      offset: const Offset(4, 4),
                    ),
                  ],
                  fontWeight: FontWeight.bold,
                  color: SliderColors.categoriesColors[doc['colorId']],
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

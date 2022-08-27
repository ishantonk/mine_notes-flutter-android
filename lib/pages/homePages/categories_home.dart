import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/categories_card_list.dart';
import 'package:mine_notes/widgets/widgets.dart';

class CategoriesHome extends StatelessWidget {
  const CategoriesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // --Header--
        HeaderWidget(pageIndex: 1),

        // --Staggered-grid-view--
        CategoriesCardList(),
      ],
    );
  }
}

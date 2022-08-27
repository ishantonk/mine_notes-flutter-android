import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/notes_card_list.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NotesHome extends StatelessWidget {
  const NotesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // --Header--
        HeaderWidget(pageIndex: 0),

        // --Staggered-grid-view--
        NotesCardList(),
      ],
    );
  }
}

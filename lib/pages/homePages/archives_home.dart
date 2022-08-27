import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/notes_card_list.dart';
import 'package:mine_notes/widgets/widgets.dart';

class ArchivesHome extends StatelessWidget {
  const ArchivesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        // --Header--
        HeaderWidget(pageIndex: 2),

        // --Staggered-grid-view--
        NotesCardList(forArchive: true),
      ],
    );
  }
}

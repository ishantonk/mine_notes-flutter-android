import 'package:flutter/material.dart';
import 'package:mine_notes/widgets/widgets.dart';

class SettingsHome extends StatelessWidget {
  const SettingsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --Header--
        HeaderWidget(pageIndex: 3)

        // --Staggered-grid-view--
        // TODO: Add a note here.
      ],
    );
  }
}

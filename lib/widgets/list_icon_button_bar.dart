import 'package:flutter/material.dart';
import 'package:mine_notes/utils/utils.dart';

class ListIconButtonBar extends StatefulWidget {
  const ListIconButtonBar(
      {Key? key,
      required this.title,
      required this.selectedIconId,
      required this.getChangedIconId})
      : super(key: key);
  final String title;
  final int selectedIconId;
  final Function getChangedIconId;

  @override
  State<ListIconButtonBar> createState() => _ListIconButtonBarState();
}

class _ListIconButtonBarState extends State<ListIconButtonBar> {
  late int stateIconId;

  @override
  void initState() {
    super.initState();
    stateIconId = widget.selectedIconId;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title.
        Align(
          alignment: Alignment.center,
          child: Text(widget.title),
        ),

        const SizedBox(height: 4),
        // List of icons.
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          children: List.generate(ListIcons.categoriesIcons.length,
              (index) => _buildIconButton(context, index)),
        ),
      ],
    );
  }

  // * Helper method to build icon button.
  Container _buildIconButton(BuildContext context, int index) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: stateIconId == index
            ? Colors.black.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: stateIconId == index
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            stateIconId = index;
          });
          widget.getChangedIconId(index);
        },
        icon: Icon(ListIcons.categoriesIcons[index]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({Key? key, required this.moreOption})
      : super(key: key);
  final Function moreOption;
  // TODO: Add text editing functions for all the bottom app bar items.

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: BottomAppBar(
          color: Theme.of(context).canvasColor,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.text_bold, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.text_italic, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.text_underline, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.textalign_justifycenter, size: 20),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.link_214, size: 20),
              ),
              IconButton(
                onPressed: () async {
                  await moreOption.call();
                },
                icon: const Icon(Iconsax.more, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

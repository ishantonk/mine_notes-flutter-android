import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsSubHeader extends StatelessWidget {
  const SettingsSubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Edit profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.archive_add),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}

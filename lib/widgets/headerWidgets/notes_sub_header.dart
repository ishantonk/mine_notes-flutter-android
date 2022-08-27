import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotesSubHeader extends StatelessWidget {
  const NotesSubHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentHour = DateTime.now().hour;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hey Ishan tonk,',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),

            // Greeting text.
            Text(
              'Good ${currentHour < 12 ? 'Morning' : currentHour >= 12 && currentHour < 18 ? 'Afternoon' : currentHour >= 18 ? 'Evening' : ''}!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ],
        ),

        // Spacing.
        const SizedBox(width: 16),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[300],
          ),
          child: Icon(
            Iconsax.user,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

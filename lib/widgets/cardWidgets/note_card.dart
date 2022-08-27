import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({Key? key, required this.note, this.onTap}) : super(key: key);
  final QueryDocumentSnapshot note;
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
          builder: (context) => OptionNoteSheet(note: note),
        );
      },

      // Widget for the note card.
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        borderOnForeground: true,

        // Background for the card.
        color: SliderColors.notesColors[note['colorId']],
        shadowColor: SliderColors.notesColors[note['colorId']].withOpacity(0.2),
        surfaceTintColor:
            SliderColors.notesColors[note['colorId']].withOpacity(0.2),
        elevation: 0,
        key: ValueKey(note.id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title.
                  Text(
                    note['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Pin icon.
                  if (note['isPinned'])
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Iconsax.paperclip_2,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              // Content with max 15 lines.
              Text(
                note['content'],
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),

              // Date.
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  note['dateCreated'].toDate().toString().split(' ')[0],
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

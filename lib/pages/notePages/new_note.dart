import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/content_editor.dart';
import 'package:mine_notes/widgets/widgets.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _categoryId = ' ';
  int _colorId = 0;
  bool _isPinned = false;
  bool _isArchived = false;

  @override
  Widget build(BuildContext context) {
    void _updateCategoryId(String newCategoryId) {
      setState(() {
        _categoryId = newCategoryId;
      });
    }

    void _updateColorId(int newColorId) {
      setState(() {
        _colorId = newColorId;
      });
    }

    void _updateIsPinned(bool newIsPinned) {
      setState(() {
        _isPinned = newIsPinned;
      });
    }

    void _updateIsArchived(bool newIsArchived) {
      setState(() {
        _isArchived = newIsArchived;
      });
    }

    return Scaffold(
      // Set the background color of the scaffold.
      backgroundColor: SliderColors.notesColors[_colorId],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Button bar.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button.
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),

                  // Save button.
                  BlocListener<NoteCubit, NoteState>(
                    listener: (context, state) {
                      if (state is NoteCreateDone) {
                        // Show a snackbar with success message.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Note has been created successfully!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        // Navigate to the previous page.
                        Navigator.pop(context);
                      } else if (state is NoteCreateError) {
                        // Show a snackbar with error message.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: ButtonWidget(
                      icon: Icons.check,
                      label: 'Save',
                      size: const ButtonSize(width: 100, height: 40),
                      onPressed: () {
                        _onSave(context);
                      },
                    ),
                  )
                ],
              ),

              // Title input.
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                autocorrect: false,
                enableSuggestions: false,
                maxLines: 1,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Created date.
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Created: ${DateTime.now().toString().split(' ')[0]}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              // Content input.
              const SizedBox(height: 8),
              Expanded(
                // child: ContentEditor(),
                child: TextField(
                  controller: _contentController,
                  autocorrect: false,
                  enableSuggestions: false,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Content',
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              // Bottom app-bar.
              const SizedBox(height: 8),
              BottomAppBarWidget(
                moreOption: () {
                  showModalBottomSheet(
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => NewNoteSheet(
                      categoryId: _categoryId,
                      colorId: _colorId,
                      isPinned: _isPinned,
                      isArchived: _isArchived,
                      onCategoryIdChanged: _updateCategoryId,
                      onColorIdChanged: _updateColorId,
                      onIsPinnedChanged: _updateIsPinned,
                      onIsArchivedChanged: _updateIsArchived,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // * Function to save the note.
  _onSave(BuildContext context) {
    // Checking internet connection.
    Connectivity().checkConnectivity().then(
      (result) {
        if (result == ConnectivityResult.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          // Cubit for saving a note.
          BlocProvider.of<NoteCubit>(context).createNote(
            title: _titleController.text,
            content: _contentController.text,
            categoryId: _categoryId,
            colorId: _colorId,
            isPinned: _isPinned,
            isArchived: _isArchived,
          );
        }
      },
    );
  }
}

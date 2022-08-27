import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_notes/cubits/cubits.dart';
import 'package:mine_notes/utils/utils.dart';
import 'package:mine_notes/widgets/widgets.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key, required this.note}) : super(key: key);
  final DocumentSnapshot note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _categoryId = ' ';
  int _colorId = 0;
  bool _isPinned = false;
  bool _isArchived = false;
  Timestamp _dateCreated = Timestamp.now();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.note['title'];
    _contentController.text = widget.note['content'];
    _categoryId = widget.note['categoryId'];
    _colorId = widget.note['colorId'];
    _isPinned = widget.note['isPinned'];
    _isArchived = widget.note['isArchived'];
    _dateCreated = widget.note['dateCreated'];
  }

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

    void _onShare() {
      // TODO: Share the note implementation.
    }

    void _onDuplicate() {
      BlocProvider.of<NoteCubit>(context).duplicateNote(noteId: widget.note.id);
    }

    void _onDelete() {
      BlocProvider.of<NoteCubit>(context).deleteNote(noteId: widget.note.id);
    }

    return Scaffold(
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

                  // Update button.
                  BlocListener<NoteCubit, NoteState>(
                    listener: (context, state) {
                      if (state is NoteUpdateDone) {
                        // Show a snackbar with success message.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Note has been updated successfully!'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        // Navigate to the previous page.
                        Navigator.pop(context);
                      } else if (state is NoteUpdateError) {
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
                      label: 'Update',
                      size: const ButtonSize(width: 100, height: 40),
                      onPressed: () {
                        _onUpdate(context);
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

              // Dates.
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date created.
                    const SizedBox(height: 8),
                    Text(
                      'Created: ${_dateCreated.toDate().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    // Edited date.
                    const SizedBox(height: 2),
                    Text(
                      'Last edited: ${DateTime.now().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // Content input.
              const SizedBox(height: 8),
              Expanded(
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
                    builder: (context) => EditNoteSheet(
                      categoryId: _categoryId,
                      colorId: _colorId,
                      isPinned: _isPinned,
                      isArchived: _isArchived,
                      onCategoryIdChanged: _updateCategoryId,
                      onColorIdChanged: _updateColorId,
                      onIsPinnedChanged: _updateIsPinned,
                      onIsArchivedChanged: _updateIsArchived,
                      onShareTap: _onShare,
                      onDuplicateTap: _onDuplicate,
                      onDeleteTap: _onDelete,
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

  // * Helper function for update note.
  _onUpdate(BuildContext context) {
    // Checking internet connection.
    // ? Used networkCubit to check internet connection.
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
          // Update note using cubit function.
          BlocProvider.of<NoteCubit>(context).updateNote(
            title: _titleController.text,
            content: _contentController.text,
            categoryId: _categoryId,
            colorId: _colorId,
            isPinned: _isPinned,
            isArchived: _isArchived,
            noteId: widget.note.id,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ContentEditor extends StatefulWidget {
  const ContentEditor({Key? key}) : super(key: key);

  @override
  State<ContentEditor> createState() => _ContentEditorState();
}

class _ContentEditorState extends State<ContentEditor> {
  final QuillController _contentController = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuillToolbar.basic(controller: _contentController),
        const SizedBox(height: 16),
        Expanded(
          child: QuillEditor.basic(
            controller: _contentController,
            readOnly: false,
          ),
        ),
      ],
    );
  }
}

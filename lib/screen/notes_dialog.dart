import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesDialog extends StatefulWidget {
  final int? noteId;
  final String? title;
  final String? content;
  final int colorIndex;
  final List<Color> noteColors;
  final Function(String,String,int,String) onNoteSaved;

  const NotesDialog({
    super.key,
    this.noteId,
    this.title,
    this.content,
    required this.colorIndex,
    required this.noteColors,
    required this.onNoteSaved,
  });

  @override
  State<NotesDialog> createState() => NotesDialogState();
}

class NotesDialogState extends State<NotesDialog> {
  late int selectedColorIndex;

  // FIX: Controllers are defined once (not recreated every rebuild)
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late String currentDate;

  @override
  void initState() {
    super.initState();
    selectedColorIndex = widget.colorIndex;

    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.content);

    currentDate = DateFormat('E d MMM').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: widget.noteColors[selectedColorIndex],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        widget.noteId == null ? 'Add Note' : 'Edit Note',
        style: const TextStyle(color: Colors.black87),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentDate,
              style: const TextStyle(color: Colors.black54, fontSize: 15),
            ),

            const SizedBox(height: 16),

            // TITLE FIELD
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.5),
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // DESCRIPTION FIELD (FIXED)
            TextField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 8,
              children: List.generate(
                widget.noteColors.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: widget.noteColors[index],
                    child: selectedColorIndex == index
                        ? const Icon(Icons.check,
                            color: Colors.black54, size: 16)
                        : null,
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: ()async  {
              widget.onNoteSaved(
              titleController.text,
              descriptionController.text,
              selectedColorIndex,
              currentDate,
            );

            Navigator.pop(context);
    
           
          },
          
          child: const Text('Save'),
        ),
      ],
    );
  }
}

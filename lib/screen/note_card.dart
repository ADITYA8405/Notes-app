import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onDelete;
  final Function onTap;
  final List<Color> noteColors;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onTap,
    required this.noteColors,
  });

  @override
  Widget build(BuildContext context) {
    final colorIndex = note['color'] as int;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: noteColors[colorIndex],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date
            Text(
              note['date'],
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8),

            // Title
            Text(
              note['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Expanded(
              child: Text(
                note['description'],
                style: const TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                ),
                overflow: TextOverflow.fade,
              ),
            ),

            // DELETE BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black54,
                    size: 20,
                  ),
                  onPressed: () => onDelete(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

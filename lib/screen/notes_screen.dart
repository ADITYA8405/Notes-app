import 'package:flutter/material.dart';
import 'package:notes_app/database/notesdatabase.dart';
import 'package:notes_app/screen/note_card.dart';
import 'package:notes_app/screen/notes_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Fetch notes from DB
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    //Notesdatabase.instance.deleteOldDatabase().then((_) {
    fetchNotes();   // Now load fresh DB

  }

  Future<void> fetchNotes() async {
    final fetchNotes = await Notesdatabase.instance.getNotes();
    setState(() {
      notes = fetchNotes;
    });
  }

  final List<Color> noteColors = [
    const Color(0xFFF3E5F5),
    const Color(0xFFFFF3E0),
    const Color(0xFFE1F5FE),
    const Color(0xFFFCE4EC),
    const Color(0xFF89CFF0),
    const Color(0xFFFABABA),
    const Color(0xFFB2F9FC),
    const Color(0xFFFFD59A),
    const Color(0xFFFEE4B5),
    const Color(0xFF98FB98),
    const Color(0xFFFFD7D0),
    const Color(0xFFFAEEEE),
    const Color(0xFFFFAAD2),
    const Color(0xFFD3D3D3),
  ];
void showNoteDialog({
  int? id,
  String? title,
  String? content,
  int colorIndex = 0,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return NotesDialog(
        colorIndex: colorIndex,
        noteColors: noteColors,
        noteId: id,
        title: title,
        content: content,
       onNoteSaved: (
  newTitle,
  newDescription,
  selectedColorIndex,
  currentDate,
) async {
  if (id == null) {
    await Notesdatabase.instance.addNote(
      newTitle,
      newDescription,
      currentDate,        // ✅ date should be 3rd
      selectedColorIndex, // ✅ color should be 4th
    );
  } else {
    await Notesdatabase.instance.updateNote(
      newTitle,
      newDescription,
      currentDate,        // ✅ date should be 3rd
      selectedColorIndex, // ✅ color should be 4th
      id,
    );
  }

  fetchNotes();
},
        
    
      );
    },
  );
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ✅ FIXED FAB — now opens the dialog
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteDialog();
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes_outlined, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 10),
                  const Text("No notes found"),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.80,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteCard(
                    note: note,
                    onDelete: () async {
                      await Notesdatabase.instance.deleteNote(note['id']);
                      fetchNotes();
                    },
                    onTap: () {
                      showNoteDialog(
                        id: note['id'],
                        title: note['title'],
                        content: note['description'],
                        colorIndex: note['color'],
                      );
                    },
                    noteColors: noteColors,
                  );
                },
              ),
            ),
    );
  }
}

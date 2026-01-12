import 'package:flutter/material.dart';
import 'package:notes_app/screen/notes_screen.dart';

void main() {
  runApp( NotesApp());
}
class NotesApp extends StatelessWidget{
 const NotesApp({super.key});

 @override
  Widget build(BuildContext context) {
    return MaterialApp( // pure app ka infrasturcure ka desgin material app ko kehte h
    title: 'Notes app',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blueGrey
    ),
 home:const NotesScreen()
    );
  }


}
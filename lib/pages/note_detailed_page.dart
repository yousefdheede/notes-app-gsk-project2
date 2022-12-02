import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/models/controllers/note_controller.dart';
import 'package:note_app/models/models/note_model.dart';
import 'package:note_app/pages/add_note_page.dart';
import 'package:note_app/ui/styles/text_styles.dart';
import 'package:note_app/widgets/icon_button.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;
  final _noteController = Get.find<NoteController>();
  NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          onPressed: () {
            Get.to(() => AddNotePage(
                  isUpdate: true,
                  note: note,
                ));
          },
          child: const Icon(Icons.edit),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _body(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyIconButton(
            onTap: () {
              Get.back();
            },
            icon: Icons.keyboard_arrow_left,
          ),
          MyIconButton(
            onTap: () {
              _deleteNoteFromDB();
              Get.back();
            },
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }

  _body() {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: titleTextStyle,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(note.date, style: dateTextStyle),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      note.text,
                      style: bodyTextStyle,
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deleteNoteFromDB() async {
    await _noteController.deleteNote(note: note);
  }
}

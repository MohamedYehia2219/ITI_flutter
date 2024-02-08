import 'package:flutter/material.dart';
import 'package:notes_app/db/CURD.dart';
import 'package:notes_app/model/Note.dart';
import 'package:notes_app/utils/date_time_manager.dart';
import 'package:notes_app/utils/extensions/WidgetEx.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _editFormKey = GlobalKey();
  late TextEditingController _noteTitleController;
  late TextEditingController _noteTextController;

  late TextEditingController _editNoteTitleController;
  late TextEditingController _editNoteTextController;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _noteTitleController = TextEditingController();
    _noteTextController = TextEditingController();
    _viewData();
  }

  @override
  void dispose() {
    super.dispose();
    _noteTextController.dispose();
    _noteTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) =>
                          value!.isEmpty ? 'This Field is required' : null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Note Title', icon: Icon(Icons.notes)),
                    ),
                    TextFormField(
                      controller: _noteTextController,
                      validator: (value) =>
                          value!.isEmpty ? 'This Field is required' : null,
                      keyboardType: TextInputType.text,
                      decoration: (const InputDecoration(
                          labelText: 'Note Text', icon: Icon(Icons.notes))),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Note n = Note(
                                title: _noteTitleController.value.text,
                                text: _noteTextController.value.text,
                                date: DateTimeManager.currentDateTime(),
                              color: 0,
                            );
                            _saveNote(n);
                          }
                        },
                        child: const Text('Add Note'))
                  ],
                )),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ListTile(
                      leading: Icon(Icons.note_alt),
                      title: Text(notes[index].title),
                      subtitle: Text(notes[index].text),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  _deleteNote(notes[index].id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  showEditDialog(notes[index]);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: notes.length)
          ],
        )),
      ),
    );
  }

  void _saveNote(Note n) {
    CURD.curd.save(n).then((value) {
      //1-message
      widget.showMessage(context, 'Note inserted successfully');
      //2-clear
      clearText();
      //3-view data
      _viewData();
    });
  }

  void clearText() {
    _noteTitleController.text = '';
    _noteTextController.text = '';
  }

  void _viewData() {
    CURD.curd.view().then((value) {
      setState(() {
        notes = value;
      });
    });
  }

  void _deleteNote(int? id) {
    CURD.curd.delete(id!).then((value) {
      widget.showMessage(context, 'Note deleted successfully');
      _viewData();
    });
  }

  void showEditDialog(Note note) {
    _editNoteTitleController = TextEditingController(text: note.title);
    _editNoteTextController = TextEditingController(text: note.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Update Note'),
          content: Wrap(
            children: [
              Form(
                key: _editFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _editNoteTitleController,
                      validator: (value) =>
                          value!.isEmpty ? 'This Field is required' : null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Note Title', icon: Icon(Icons.notes)),
                    ),
                    TextFormField(
                      controller: _editNoteTextController,
                      validator: (value) =>
                          value!.isEmpty ? 'This Field is required' : null,
                      keyboardType: TextInputType.text,
                      decoration: (const InputDecoration(
                          labelText: 'Note Text', icon: Icon(Icons.notes))),
                    ),
                  ],
                ),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (_editFormKey.currentState!.validate()) {
                    note.title = _editNoteTitleController.value.text;
                    note.text = _editNoteTextController.value.text;
                    _updateNote(note);
                    Navigator.pop(context);
                  }
                },
                child: Text('Update')),
          ]),
    );
  }

  void _updateNote(Note note) {
    CURD.curd.update(note).then((value) {
      widget.showMessage(context, 'Note updated successfully');
      _viewData();
    });
  }
}

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

  List<Color> colors = [
    Colors.lightBlue,
    Colors.green,
    Colors.purpleAccent,
    Colors.deepOrange,
  ];
  int selectedColor = 0;

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
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            selectedColor = index;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              color: colors[index],
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.all(5),
                            ),
                            if (selectedColor == index) Icon(Icons.check),
                          ],
                        ),
                      ),
                      itemCount: colors.length,
                      padding: const EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 5.0,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Note n = Note(
                              title: _noteTitleController.value.text,
                              text: _noteTextController.value.text,
                              date: DateTimeManager.currentDateTime(),
                              color: selectedColor,
                              lastUpdate: DateTimeManager.currentDateTime());
                          _saveNote(n);
                        }
                      },
                      child: const Text('Add Note')
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: _viewData(),
                  builder: (context, AsyncSnapshot<List<Note>> snapshot) {
                    if (snapshot.hasData) {
                      List<Note> myNotes = snapshot.data!;
                      return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return  Tooltip(message: myNotes[index].lastUpdate , showDuration: const Duration(seconds: 2),
                              child: Container(
                              margin:EdgeInsets.all(10) ,
                              color: colors[myNotes[index].color],
                              child: ListTile(
                                leading: const Icon(Icons.note_alt),
                                title: Text(myNotes[index].title),
                                subtitle: Text(myNotes[index].text),
                                trailing: SizedBox(width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _deleteNote(myNotes[index].id);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showEditDialog(myNotes[index]);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),);
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: myNotes.length);
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error!.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
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
      setState(() {});
    });
  }

  void clearText() {
    _noteTitleController.text = '';
    _noteTextController.text = '';
  }

  // void _viewData() {
  //   CURD.curd.view().then((value) {
  //     setState(() {
  //       notes = value;
  //     });
  //   });
  // }
  Future<List<Note>> _viewData() {
    return CURD.curd.view();
  }

  void _deleteNote(int? id) {
    CURD.curd.delete(id!).then((value) {
      widget.showMessage(context, 'Note deleted successfully');
      _viewData();
      setState(() {});
    });
  }

  void showEditDialog(Note note) {
    _editNoteTitleController = TextEditingController(text: note.title);
    _editNoteTextController = TextEditingController(text: note.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Update Note'),
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
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (_editFormKey.currentState!.validate()) {
                    note.title = _editNoteTitleController.value.text;
                    note.text = _editNoteTextController.value.text;
                    note.lastUpdate=DateTimeManager.currentDateTime();
                    _updateNote(note);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update')),
          ]),
    );
  }

  void _updateNote(Note note) {
    CURD.curd.update(note).then((value) {
      widget.showMessage(context, 'Note updated successfully');
      _viewData();
      setState(() {});
    });
  }
}

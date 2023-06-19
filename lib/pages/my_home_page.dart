import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/note_bloc.dart';
import 'package:todo_bloc/models/note_model.dart';
import 'package:todo_bloc/pages/add_update_page.dart';
import 'package:todo_bloc/widgets/custom_app_bar.dart';
import 'package:todo_bloc/widgets/note_list_item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteBloc, NoteState>(
      listener: (context, state) {

        switch (state.status) {
          case 'update':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Note update successfully')));
            break;
          case 'add':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Note add successfully')));
            break;
          case 'delete':
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Note delete successfully')));
            break;
        }


      },
      child: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          List<NoteModel> notes = context.read<NoteBloc>().state.noteList;
          return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      CustomAppBar(title: 'Notes', icon: Icons.search),
                      Expanded(
                        child: ListView.builder(
                            itemCount: notes.length,
                            itemBuilder: (context, index) {
                              return NoteListItem(
                                noteModel: notes[index],
                                index: index,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddUpdatePage(
                            isEditing: false,
                          )));
                },
                child: Icon(Icons.add),
              ));
        },
      ),
    );
  }
}

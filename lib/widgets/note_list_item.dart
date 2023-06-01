import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/app_constants.dart';
import 'package:todo_bloc/bloc/note_bloc.dart';

import '../models/note_model.dart';



class NoteListItem extends StatefulWidget {
  const NoteListItem({Key? key}) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  void initState() {
    BlocProvider.of<NoteBloc>(context).fetchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: BlocBuilder<NoteBloc,NoteState>(
        builder: (context, state) {
          List<NoteModel> notes = BlocProvider.of<NoteBloc>(context).notes;
           return ListView.builder(
             padding: EdgeInsets.zero,
             itemCount: notes.length,
             itemBuilder: (context, index) {
               return Padding(
                 padding: const EdgeInsets.symmetric(vertical: 4),
                 child: GestureDetector(
                   onTap: () {},
                   child: Container(
                     decoration: BoxDecoration(
                       color:AppConstants.colors[notes[index].color],
                       borderRadius: BorderRadius.circular(16),
                     ),
                     padding: EdgeInsets.only(
                       left: 16,
                       top: 24,
                       bottom: 24,
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         ListTile(
                           title: Text(notes[index].title, style: TextStyle(
                             fontSize: 26,
                             color: Colors.black,
                           ),),
                           subtitle: Padding(
                             padding: const EdgeInsets.symmetric(vertical: 16),
                             child: Text(
                               notes[index].description, style: TextStyle(
                               fontSize: 18,
                               color: Colors.black.withOpacity(0.4),
                             ),),
                           ),
                           trailing: IconButton(
                             onPressed: () {},
                             icon: const Icon(
                               Icons.delete,
                               color: Colors.black,
                               size: 30,
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 24),
                           child: Text(
                              '',
                             style: TextStyle(
                               color: Colors.black.withOpacity(.4),
                             ),
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               );
             },
           );
        },
      ),
    );
  }
}

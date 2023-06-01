import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todo_bloc/app_constants.dart';
import '../models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  List<NoteModel> notes =[];

  NoteBloc() : super(NoteState.initial()) {
    on<AddNoteEvent>(_onAddNoteEvent);
    }

    void _onAddNoteEvent(AddNoteEvent event,Emitter<NoteState> emit) async{
    final box = await Hive.box<NoteModel>('note_box');
    await box.add(event.note);
    fetchAllNotes();
    emit(NoteState(noteList: notes));
    }


   fetchAllNotes() async {
    final box = await Hive.box<NoteModel>('note_box');
    box.values.forEach((element) {
      notes.add(element);
    });
  }

}




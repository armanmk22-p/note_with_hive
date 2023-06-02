import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  List<NoteModel> notes =[];

  NoteBloc() : super(NoteState.initial()) {
    on<AddNoteEvent>(_onAddNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    }

    void _onAddNoteEvent(AddNoteEvent event,Emitter<NoteState> emit) async{
    final box =  Hive.box<NoteModel>('note_box');
    await box.add(event.note);
    getAllNotes();
     emit(NoteState(noteList: notes));
    }

  void _onUpdateNoteEvent(UpdateNoteEvent event, Emitter<NoteState> emit)async{
    final box =  Hive.box<NoteModel>('note_box');
    await box.putAt(event.index, event.note);
    getAllNotes();
    emit(NoteState(noteList: notes));
  }



    void _onDeleteNoteEvent(DeleteNoteEvent event, Emitter<NoteState> emit)async{
      final box = Hive.box<NoteModel>('note_box');
      await event.note.delete();
      getAllNotes();
      emit(NoteState(noteList: notes));
    }


  void getAllNotes()  {
    var box =  Hive.box<NoteModel>('note_box');
    notes = box.values.toList();
    //  for (var element in box.values) {
    //    notes.add(element);
    // }
  }

}


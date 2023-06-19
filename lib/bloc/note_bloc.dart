

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../models/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  List<NoteModel> notes =[];
  late  Box box;

  NoteBloc() : super(NoteState.initial()) {
    on<AddNoteEvent>(_onAddNoteEvent);
    on<DeleteNoteEvent>(_onDeleteNoteEvent);
    on<UpdateNoteEvent>(_onUpdateNoteEvent);
    }

    void _onAddNoteEvent(AddNoteEvent event,Emitter<NoteState> emit) async{
    box =  Hive.box<NoteModel>('note_box');
    await box.add(event.note);
    getAllNotes();
     emit(NoteState(noteList: notes,status: event.status));
    }

  void _onUpdateNoteEvent(UpdateNoteEvent event, Emitter<NoteState> emit)async{
    box =  Hive.box<NoteModel>('note_box');
    await box.putAt(event.index, event.note);
    getAllNotes();
    emit(NoteState(noteList: notes,status: event.status));
  }



    void _onDeleteNoteEvent(DeleteNoteEvent event, Emitter<NoteState> emit)async{
      box = Hive.box<NoteModel>('note_box');
     // await event.note.delete();
      await box.deleteAt(event.index);
      getAllNotes();
      emit(NoteState(noteList: notes,status: event.status));
    }


  void getAllNotes()  {
    var box =  Hive.box<NoteModel>('note_box');
    notes = box.values.toList();

    /*----------------------------------------------
    notes = box.values.toList();
    final reversedNotes = notes.reversed.toList();
    //
    we use "reversed" to sort items in order from the latest to the oldest (from new to old)
     */

    //  for (var element in box.values) {
    //    notes.add(element);
    // }
  }

}


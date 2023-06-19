part of 'note_bloc.dart';

class NoteState extends Equatable {
  final List<NoteModel> noteList;
  final status;
  const NoteState({required this.noteList,this.status});

  List<Object?> get props => [noteList,status];

  factory NoteState.initial() {
    return NoteState(noteList: []);
  }

// class NoteInitial extends NoteState{
//   final List<NoteModel> emptyNotes;n `
//   NoteInitial({this.emptyNotes =const []});
// }

// class AddAndUpdateNote extends NoteState{
//   final List<NoteModel> notes;
//
//   const AddAndUpdateNote({required this.notes});
//
//   @override
//   List<Object?> get props => [notes];
// }

}
part of 'note_bloc.dart';

class NoteState extends Equatable {
  final List<NoteModel> noteList;
  const NoteState({required this.noteList});
  List<Object?> get props => [noteList];

  factory NoteState.initial() {
    return NoteState(noteList: []);
  }

// class NoteInitial extends NoteState{
//   final List<NoteModel> emptyNotes;
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
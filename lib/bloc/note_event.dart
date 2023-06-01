part of 'note_bloc.dart';

 abstract class NoteEvent extends Equatable{
   const NoteEvent();
}

class AddNoteEvent extends NoteEvent{
   final NoteModel note;

   AddNoteEvent(this.note);

  @override
  List<Object?> get props => [note];

}



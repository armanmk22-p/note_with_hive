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

class UpdateNoteEvent extends NoteEvent{
   final int index;
  final NoteModel note;

  UpdateNoteEvent(this.note,this.index);

  @override
  List<Object?> get props => [note];

}

class DeleteNoteEvent extends NoteEvent {
   final NoteModel note;

   DeleteNoteEvent({required this.note});

  @override
  List<Object?> get props => [note];
}




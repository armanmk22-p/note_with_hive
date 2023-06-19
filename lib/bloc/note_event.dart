part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class AddNoteEvent extends NoteEvent {
  final NoteModel note;
  final status;

  AddNoteEvent({
    required this.note,
    required this.status,
  });

  @override
  List<Object?> get props => [note, status];
}

class UpdateNoteEvent extends NoteEvent {
  final int index;
  final NoteModel note;
  final status;

  UpdateNoteEvent({
    required this.note,
    required this.index,
    required this.status,
  });

  @override
  List<Object?> get props => [note, status];
}

class DeleteNoteEvent extends NoteEvent {
  // final NoteModel note;
  final index;
  final status;

  DeleteNoteEvent({required this.index, required this.status});

  @override
  List<Object?> get props => [index, status];
}

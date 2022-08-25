// Note's table name
final String tableNotes = 'notes';

class NoteField {
  static final String id = '_id';
  static final String number = 'number';
  static final String title = 'title';
  static final String message = 'message';
  static final String time = 'time';
}

class NoteModal {
  final int? id;
  final int number;
  final String title;
  final String message;
  final DateTime createdAt;

  NoteModal(
      {this.id,
      required this.number,
      required this.title,
      required this.message,
      required this.createdAt});
}

// Note's table name
const String tableNotes = 'notes';

// create column names
class NoteField {
  static const String id = '_id';
  static const String number = 'number';
  static const String title = 'title';
  static const String message = 'message';
  static const String time = 'time';
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

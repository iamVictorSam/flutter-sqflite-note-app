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

  // creating to json method
  Map<String, Object?> toJson() => {
        NoteField.id: id,
        NoteField.number: number,
        NoteField.title: title,
        NoteField.message: message,
        NoteField.time: createdAt.toIso8601String(),
      };


  // creating a copy of our current note model
  NoteModal copy({
    int? id,
    int? number,
    String? title,
    String? message,
    DateTime? createdAt,
  }) =>
      NoteModal(
          id: id ?? this.id,
          title: title ?? this.title,
          message: message ?? this.message,
          number: number ?? this.number,
          createdAt: createdAt ?? this.createdAt);
}

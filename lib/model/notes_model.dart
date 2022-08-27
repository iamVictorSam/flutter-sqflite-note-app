// Note's table name
const String tableNotes = 'notes';

// create column names
class NoteField {
  static final List<String> allValues = [id, number, title, message, time];

  static const String id = '_id';
  static const String number = 'number';
  static const String title = 'title';
  static const String message = 'message';
  static const String time = 'time';
}

class NoteModel {
  final int? id;
  final int number;
  final String title;
  final String message;
  final DateTime createdAt;

  NoteModel(
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

  static NoteModel fromJson(Map<String, Object?> json) => NoteModel(
        id: json[NoteField.id] as int?,
        title: json[NoteField.title] as String,
        message: json[NoteField.message] as String,
        number: json[NoteField.number] as int,
        createdAt: DateTime.parse(json[NoteField.time] as String),
      );

  // creating a copy of our current note model
  NoteModel copy({
    int? id,
    int? number,
    String? title,
    String? message,
    DateTime? createdAt,
  }) =>
      NoteModel(
          id: id ?? this.id,
          title: title ?? this.title,
          message: message ?? this.message,
          number: number ?? this.number,
          createdAt: createdAt ?? this.createdAt);
}

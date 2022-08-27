import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:note_app/model/notes_model.dart';

class NotesDb {
  //Creating note instance
  static final NotesDb instance = NotesDb._init();

  static Database? _database;

  NotesDb._init();

  //Creating database connection
  Future<Database?> get database async {
    // if database already exist return
    if (_database != null) return _database;

    // initialize if not
    _database = await _initDB('notes.db');
    return _database;
  }

  // getting path to store database in phone storage.
  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database database, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    // creating database table with schema
    await database.execute('''

      CREATE TABLE $tableNotes (
        $NoteField.id $idType,
        $NoteField.number $integerType,
        $NoteField.title $textType,
        $NoteField.message $textType,
        $NoteField.time $textType,

      )

''');
  }

  //Performing CRUDE operation
  //Create note
  Future<NoteModel> createNote(NoteModel notesDb) async {
    // getting database reference
    final database = await instance.database;

    final id = await database!.insert(tableNotes, notesDb.toJson());
    return notesDb.copy(id: id);
  }

  //Read a Single Note
  Future<NoteModel> retrieveSingleNote(int id) async {
    final database = await instance.database;

    final maps = await database!.query(
      tableNotes,
      columns: NoteField.allValues,
      //This syntax prevent sql injection (data attacks)
      where: '$NoteField.id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NoteModel.fromJson(maps.first);
    } else {
      throw Exception('id $id not found');
    }
  }

  // Retrieve all Notes
  Future<List<NoteModel>> retrieveAllNotes() async {
    final database = await instance.database;

    const ascOrder = '${NoteField.time} ASC';
    final result = await database!.query(tableNotes, orderBy: ascOrder);

    return result.map((x) => NoteModel.fromJson(x)).toList();
  }

  // Upate Note
  Future<int> updateNote(NoteModel noteModel) async {
    final database = await instance.database;

    return database!.update(
      tableNotes,
      noteModel.toJson(),
      where: '$NoteField.id = ?',
      whereArgs: [noteModel.id],
    );
  }

 // Delete Note
  Future<int> deleteNote(int id) async {
    final database = await instance.database;

    return database!.delete(
      tableNotes,
      where: '$NoteField.id = ?',
      whereArgs: [id],
    );
  }

  // closing database
  Future closeDatabase() async {
    final database = await instance.database;

    database!.close();
  }
}

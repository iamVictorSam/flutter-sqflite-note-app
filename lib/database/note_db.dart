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

  // closing database
  Future closeDatabase() async {
    final database = await instance.database;

    database!.close();
  }
}

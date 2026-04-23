import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class SqfliteService {

  static final SqfliteService _instance = SqfliteService._internal();
  factory SqfliteService() => _instance;
  SqfliteService._internal();

  static Database? _database;


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ora_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

Future _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE reviews (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId INTEGER NOT NULL,
      isReviewed INTEGER NOT NULL DEFAULT 1,   
      rating INTEGER NOT NULL,
      comment TEXT,
      images TEXT,                             
    )
  ''');
}
}
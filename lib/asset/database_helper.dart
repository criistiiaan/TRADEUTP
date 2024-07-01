import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'marketplace.db');
    return await openDatabase(
      path,
      version: 7,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 8) {
      await db.execute('ALTER TABLE items ADD COLUMN transaction_type TEXT');
    }
    print( '''Select users.Name, users.Surname From users 
    INNER JOIN items ON items.fromUsers = users.id WHERE items.id = 1''');
  }
  Future<void> _onCreate(Database db, int version) async {
     await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        type TEXT,
        description TEXT,
        price REAL,
        image TEXT,
        transaction_type TEXT,
        fromUsers INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        surname TEXT,
        email TEXT,
        password TEXT,
        facultad TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE favorite (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fromUsers INTEGER,
        fromItems INTEGER,
        state INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE messenger(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fromUsersRemitente INTEGER,
        fromUsersDestinatario INTEGER,
        mensaje TEXT,
        state INTEGER
      );
    ''');
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    Database db = await database;
    return await db.insert('items', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    Database db = await database;
    return await db.query('items');
  }
  Future<List<Map<String, dynamic>>> getItemsType( String data) async {
    Database db = await database;
    if(data != 'Todo'){
      return await db.query('items',where: 'type = ?',whereArgs: [data], );}
    return getItems();
  }


  Future<int> updateItem(Map<String, dynamic> item) async {
    Database db = await database;
    int id = item['id'];
    return await db.update('items', item, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    Database db = await database;
    return await db.delete('items', where: 'id = ?', whereArgs: [id]);
  }
  // CRUD para la tabla users
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }
<<<<<<< Updated upstream
=======
  Future<List<Map<String, dynamic>>> getSelectUsers(int idUser) async {
    Database db = await database;
    return await db.query('users', where:'id = ?', whereArgs: [idUser]);
  }
  Future<List<Map<String, dynamic>>> getUserByItem(int idItem) async {
    Database db = await database;
    return await db.rawQuery('''Select users.name, users.surname, users.facultad From users 
    INNER JOIN items ON items.fromUsers = users.id WHERE items.id = $idItem ''');
  }
>>>>>>> Stashed changes

  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    int id = user['id'];
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD para la tabla favorite
  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    Database db = await database;
    return await db.insert('favorite', favorite);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    Database db = await database;
    return await db.query('favorite');
  }

  Future<int> updateFavorite(Map<String, dynamic> favorite) async {
    Database db = await database;
    int id = favorite['id'];
    return await db.update('favorite', favorite, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteFavorite(int id) async {
    Database db = await database;
    return await db.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }
}

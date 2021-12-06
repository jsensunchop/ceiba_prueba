import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;

    // If database don't exists, create one
    _database = await initDB();

    return _database!;
  }

  // Create the database and the Employee table
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'posts_manager.db');

    print(path);

    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''CREATE TABLE User(
              id INTEGER PRIMARY KEY,
              name TEXT,
              username TEXT,
              email TEXT,
              phone TEXT
              )''');
          // await db.execute('''
          //     CREATE TABLE Posts(
          //         id INTEGER PRIMARY KEY,
          //         user INTEGER,
          //         title TEXT,
          //         body TEXT
          //     )
          //     ''');
        });
  }

  createUser(UserResponse newUser) async {
    // final userid = newUser.id;
    final name = newUser.name;
    final username = newUser.username;
    final email = newUser.email;
    final phone = newUser.phone;
    await deleteAllUsers();
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO User (name, username, email, phone)
    VALUES('$name', '$username', '$email', '$phone')
    ''');

    return res;
  }
  // Insert employee on database
  createPost(PostResponse newPost) async {
    await deleteAllPosts();
    final db = await database;
    final res = await db.insert('Posts', newPost.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllUsers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');

    return res;
  }
  // Delete all employees
  Future<int> deleteAllPosts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Posts');

    return res;
  }

  Future<List<PostResponse>> getAllPosts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Post");

    List<PostResponse> list =
    res.isNotEmpty ? res.map((c) => PostResponse.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<UserResponse>> getAllUsers() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM User');

    List<UserResponse> list =
    res.isNotEmpty ? res.map((c) => UserResponse.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<UserResponse>> searchUsers(String keyword) async {
    final db = await database;

    List<Map<String, dynamic>> allRows = await db
        .query('User', where: 'name LIKE ?', whereArgs: ['%$keyword%']);

    List<UserResponse> list =
    allRows.isNotEmpty ? allRows.map((c) => UserResponse.fromJson(c)).toList() : [];

    return list;

  }


}

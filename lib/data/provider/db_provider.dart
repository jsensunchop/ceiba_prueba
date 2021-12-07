import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/user_response.dart';
import 'package:sqflite/sqflite.dart';


///INSTANCIA Y DEFINICION DE LAS TABLAS DE LA BASE DE DATOS
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

  // Create the database and the User table
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'posts_manager.db');
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('''CREATE TABLE Publication(
              id INTEGER PRIMARY KEY,
              title TEXT,
              body TEXT,
              userId INTEGER
              )''');
          await db.execute('''CREATE TABLE User(
              id INTEGER PRIMARY KEY,
              name TEXT,
              username TEXT,
              email TEXT,
              phone TEXT,
              userid INTEGER
              )''');

        });
  }

  // Insert user on database
  createUser(UserResponse newUser) async {
    // final userid = newUser.id;
    final name = newUser.name;
    final username = newUser.username;
    final email = newUser.email;
    final phone = newUser.phone;
    final userId = newUser.id;
    await deleteAllUsers();
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO User (name, username, email, phone, userId)
    VALUES('$name', '$username', '$email', '$phone', '$userId')
    ''');

    return res;
  }
  // Insert publication on database
  createPublication(PostResponse newPost) async {
    final title = newPost.title;
    final body = newPost.body;
    final userId = newPost.userId;
    await deleteAllPosts();
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Publication (title, body, userId)
    VALUES('$title', '$body', '$userId')
    ''');

    return res;
  }

  // Delete all users
  Future<int> deleteAllUsers() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM User');

    return res;
  }
  // Delete all publications
  Future<int> deleteAllPosts() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Publication');

    return res;
  }

  // Get all publications
  Future<List<PostResponse>> getAllPosts() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Publication");

    List<PostResponse> list =
    res.isNotEmpty ? res.map((c) => PostResponse.fromJson(c)).toList() : [];

    return list;
  }

  // Get all publications
  Future<List<PostResponse>> getPublications() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM Publication');

    List<PostResponse> list =
    res.isNotEmpty ? res.map((c) => PostResponse.fromJson(c)).toList() : [];

    return list;
  }

  // Get all users
  Future<List<UserResponse>> getAllUsers() async {
    final db = await database;
    final res = await db.rawQuery('SELECT * FROM User');

    List<UserResponse> list =
    res.isNotEmpty ? res.map((c) => UserResponse.fromJson(c)).toList() : [];

    return list;
  }

// Filter users via name
  Future<List<UserResponse>> searchUsers(String keyword) async {
    final db = await database;

    List<Map<String, dynamic>> allRows = await db
        .query('User', where: 'name LIKE ?', whereArgs: ['%$keyword%']);

    List<UserResponse> list =
    allRows.isNotEmpty ? allRows.map((c) => UserResponse.fromJson(c)).toList() : [];

    return list;

  }

  // Filter posts via userId
  Future<List<PostResponse>> searchPosts(int user) async {
    final db = await database;
    List<Map<String, dynamic>> allRows = await db
        .query('Publication', where: 'userId LIKE ?', whereArgs: [user]);

    List<PostResponse> list =
    allRows.isNotEmpty ? allRows.map((c) => PostResponse.fromJson(c)).toList() : [];
    return list;
  }


}

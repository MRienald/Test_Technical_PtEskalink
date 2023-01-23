
import 'dart:io';

import 'package:eskalink_technical_test/data/source/local/model/dataContacts.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'contacts.db');
    return await openDatabase(
      path, 
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate (Database db, int version) async{
    await db.execute('''
      CREATE TABLE datacontacs(
        nik INTEGER PRIMARY KEY,
        nama TEXT,
        umur INTEGER,
        kota TEXT
      )
    ''');
  }

  Future<List<DataContacts>> getDataContacts() async{
    Database db = await instance.database;
    var dataContacts = await db.query('datacontacs', orderBy: 'nama');
    List<DataContacts> contactsList = [];
    if(dataContacts.isNotEmpty){
      contactsList = dataContacts.map((e) => DataContacts.fromMap(e)).toList();
    }
    return contactsList;
  }

  Future<List<DataContacts>> getDataContactsByNIK(int nik) async{
    Database db = await instance.database;
    var dataContacts = await db.query('datacontacs', where: 'nik = ?', whereArgs: [nik], orderBy: 'nama');
    List<DataContacts> contactsList = [];
    if(dataContacts.isNotEmpty){
      contactsList = dataContacts.map((e) => DataContacts.fromMap(e)).toList();
    }
    return contactsList;
  }

  Future<int> add(DataContacts dataContacts) async{
    Database db = await instance.database;
    return await db.insert('datacontacs', dataContacts.toMap());
  }

  Future<int> remove(int nik) async{
    Database db = await instance.database;
    return await db.delete('datacontacs', where: 'nik = ?', whereArgs: [nik]);
  }

  Future<int> update(DataContacts dataContacts) async{
    Database db = await instance.database;
    return await db.update('datacontacs', dataContacts.toMap(), where: 'nik = ?', whereArgs: [dataContacts.nik]);
  }
}
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrapp/models/scan_model.dart';
export 'package:qrapp/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    // PATH DONDE ALMACENAREMOS LA BASE DE DATOS
    Directory documensDirectory = await getApplicationDocumentsDirectory();
    final path = join(documensDirectory.path, 'ScansDB.db');
    // Craer base de Datos

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    // Verificar la base de datos
    final db = await database;

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final response = db!.rawInsert('''
      INSERT INTO Scans(id , tipo, valor)
      VALUES ($id,'$tipo', '$valor')
    ''');

    return response;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.insert('Scans', nuevoScan.toJson());
    // es el id del ultimo registro insertado
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel?>> getTodos() async {
    final db = await database;
    final res = await db!.query('Scans');
    return res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
  }

  Future<List<ScanModel?>> getScanTipo(String tipo) async {
    final db = await database;
    final res = await db!.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'    
    ''');
    return res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db!.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db!.rawDelete('''
      DELETE FROM Scans    
    ''');
    return res;
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DatabaseHelper {
  static Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'chitarre.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: (db, oldV, newV) async {
        await db.execute('DROP TABLE IF EXISTS chitarre');
        await db.execute('DROP TABLE IF EXISTS preferiti');
        await _createTables(db, newV);
      },
    );
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE chitarre (
        id            TEXT    PRIMARY KEY,
        nome          TEXT    NOT NULL,
        tipo          TEXT    NOT NULL,
        marca         TEXT    NOT NULL,
        stelle        INTEGER NOT NULL,
        corde         INTEGER NOT NULL,
        custodia      INTEGER NOT NULL,
        amplificatore INTEGER NOT NULL,
        accordatore   INTEGER NOT NULL,
        mancina       INTEGER NOT NULL,
        descrizione   TEXT    NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE preferiti (
        id           TEXT    PRIMARY KEY,
        chitarraId   TEXT    NOT NULL,
        note         TEXT    NOT NULL,
        priorita     TEXT    NOT NULL,
        dataAggiunta TEXT    NOT NULL
      )
    ''');
  }

  // ── CHITARRE ──────────────────────────────────────────────────────────────

  static Future<List<Chitarra>> getChitarre() async {
    final db = await _open();
    final rows = await db.query('chitarre');
    return rows.map(Chitarra.fromMap).toList();
  }

  static Future<void> saveChitarre(List<Chitarra> chitarre) async {
    final db = await _open();
    final batch = db.batch();
    batch.delete('chitarre');
    for (final c in chitarre) {
      batch.insert('chitarre', c.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  // ── PREFERITI ──────────────────────────────────────────────────────────────

  static Future<List<Preferito>> getPreferiti() async {
    final db = await _open();
    final rows = await db.query('preferiti');
    return rows.map(Preferito.fromMap).toList();
  }

  static Future<void> savePreferiti(List<Preferito> preferiti) async {
    final db = await _open();
    final batch = db.batch();
    batch.delete('preferiti');
    for (final p in preferiti) {
      batch.insert('preferiti', p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  static Future<void> upsertPreferito(Preferito p) async {
    final db = await _open();
    await db.insert('preferiti', p.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deletePreferito(String id) async {
    final db = await _open();
    await db.delete('preferiti', where: 'id = ?', whereArgs: [id]);
  }
}
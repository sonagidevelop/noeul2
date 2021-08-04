import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'diary.dart';

final String TableName = 'diarys';

class DBHelper {
  var _db;

  // open DB, create Table
  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), 'diarys.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE diarys(id TEXT PRIMARY KEY, title TEXT, text TEXT)",
        );
      },
      version: 1,
    );
    return _db;
  }

  // insertDiary
  Future<void> insertDiary(Diary diary) async {
    final db = await database;

    await db.insert(TableName, diary.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  //쿼리에 질의해서 맵을 담고 있는 리스트를 받고, 그 리스트를 메모를 담고있는 리스트로 변환시킨다.
  Future<List<Diary>> diarys() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('diarys');

    return List.generate(maps.length, (i) {
      return Diary(
        id: maps[i]['id'],
        title: maps[i]['title'],
        text: maps[i]['text'],
      );
    });
  }

  // 등록 돼 있는 아이템을 수정할 때 쓰는 메소드
  Future<void> updateDiary(Diary diary) async {
    final db = await database;

    await db.update(
      TableName,
      diary.toMap(),
      where: "id = ?",
      whereArgs: [diary.id],
    );
  }

  Future<void> deleteDiary(int id) async {
    final db = await database;

    await db.delete(
      TableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

import 'package:path/path.dart'; //acessar o caminho do bd
import 'package:sqflite/sqflite.dart'; // o bd em si

Future<Database> getDatabase() async {
  final String caminhoBanco = join(await getDatabasesPath(), 'alunos.db');
  return openDatabase(
    caminhoBanco, 
    onCreate:(db, version) {
      db.execute(
        "CREATE TABLE alunos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, matricula TEXT, telefone TEXT);"
      );
    },
    version: 1,
    );
}
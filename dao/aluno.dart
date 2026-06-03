import 'package:sqflite/sqflite.dart';
import '../model/aluno.dart';
import '../database/db.dart';

Future<int> insert(Aluno aluno) async {
  final Database db = await getDatabase();

  return await db.insert(
    "alunos",
    aluno.toMap() );
}

Future<List<Map<String,dynamic>>> findAll() async{
  final Database db= await getDatabase();
  List<Map<String,dynamic>> result= await db.query("alunos");// Select no banco de dados
  return result;
}


Future<int> deleteById (int id) async {
  //deleta um aluno pelo id que eu passar por parametros
  final Database db = await getDatabase();
 return db.delete("alunos", where: "id = ?", whereArgs: [id]);
}
class Aluno {
  int? id;
  String nome;
  String telefone;
  String matricula;

  Aluno ({
    this.id,
    required this.nome,
    required this.telefone,
    required this.matricula,
  });

  Map<String, dynamic> toMap(){
    //Obrigatorio para usar o SQFLITE
    return {"id":id, 
    "nome":nome, 
    "matricula": matricula, 
    "telefone":telefone,
    };
  }

  @override
  String toString(){
    return 'Aluno:{id: $id, nome: $nome, matricula: $matricula, telefone: $telefone}';
  }
}

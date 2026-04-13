
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaInicial()));
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<Aluno> alunoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text("App da 3G"),
        actions: [Text("Aqui tem butão...")],
      ),
      body: ListView.builder(
        itemCount: alunoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              "images/kanyecristao.jpg",
            ),
            title: Text(alunoList[index].nome),
            subtitle: Text(
              "Tel.: ${alunoList[index].telefone} | Matrícula: ${alunoList[index].matricula}",
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  alunoList.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaFormulario()),
          ).then((aluno) {
            setState(() {
              alunoList.add(aluno);
            });
            debugPrint("esse é meu aluno: " + aluno.nome);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TelaFormulario extends StatelessWidget {
  const TelaFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nome = TextEditingController();
    TextEditingController telefone = TextEditingController();
    TextEditingController matricula = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text("nome:"),
          TextField(controller: nome),
          Text("telefone:"),
          TextField(controller: telefone),
          Text("matricula:"),
          TextField(controller: matricula),
          ElevatedButton(
            onPressed: () {
              if (nome.text != '' &&
                  telefone.text != '' &&
                  matricula.text != '') {
                Aluno info = Aluno(nome.text, telefone.text, matricula.text);
                Navigator.pop(context, info);
              } else {
                debugPrint("Preencha todos os campos");
              }
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }
}

class Aluno {
  String nome;
  String telefone;
  String matricula;

  Aluno(this.nome, this.telefone, this.matricula);
}

class TelaDetalhe extends StatelessWidget {
  final Aluno aluno;

  const TelaDetalhe({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dados do aluno")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ÍCONE GRANDE CENTRALIZADO
            Center(child: Icon(Icons.person, size: 100)),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome: ${aluno.nome}"),
                  SizedBox(height: 10),
                  Text("Telefone: ${aluno.telefone}"),
                  SizedBox(height: 10),
                  Text("Matrícula: ${aluno.matricula}"),
                ],
              ),
            ),

            Spacer(),

            Center(
              child: IconButton(
                icon: Icon(Icons.delete, size: 40),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/aluno.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'dao/aluno.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    //padrão para qualquer app
    //SQLite de um jeito
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi; //usa essa biblioteca
  } else {
    //de outro
    databaseFactory = databaseFactoryFfiWeb;
  }



  runApp(
    MaterialApp(home: TelaInicial()),
  ); //isso que diferencia o flutter do dart.
}
//widget é qualquer coisa visual que apareça na tela
//statefull é um widget que se atualiza sem atualizar a tela inteira
//stateless é um widget que, para ser atualizado, atualiza toda a tela
//toda classe widget precisa de um construtor (build)

class TelaInicial extends StatefulWidget {
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String nomeBusca = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Container(
  height: 40,
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(25),
  ),
  child: TextField(
    decoration: InputDecoration(
      hintText: "Pesquisar aluno...",
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
    ),
    onChanged: (value) {
      setState(() {
        nomeBusca = value;
      });
    },
  ),
),
      ),
      body: FutureBuilder(
        initialData: [],
        future: nomeBusca.isEmpty
            ? findAll()
            : findByName(nomeBusca),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("Erro de conexão com o banco.");

            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              List<Map<String, dynamic>> alunos =
                  snapshot.data as List<Map<String, dynamic>>;

              return ListView.builder(
                itemCount: alunos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(alunos[index]["nome"]),
                    subtitle: Text(
                      "Matrícula: ${alunos[index]["matricula"]}",
                    ),
                  );
                },
              );
          }
        },
      ),
    
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaFormulario()),
          ).then((value) {
            setState(() {});
          }); //passa o conjunto de variáveis(informações) -> no caso, a antiga tela. Faz a rota para oqa
        },
      ), //botão
    );
  }
} //para não ter que pôr o textDirection sempre, há o materialApp, que tem pré configurações

//todo widget, quando contruído, precisa haver um direcionamento de como se apresentar (lado, direção)

//para faze ruma segunda tela, criamos outra função stateless, que se sobreporará a tela inicial como uma pilha

class TelaFormulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nome = TextEditingController();
    TextEditingController telefone = TextEditingController();
    TextEditingController matricula = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(35),
        children: [
          Text("Nome"),
          TextField(
            controller: nome,
          ), //textField trata tudo como string, então núm não tem problema
          Text("Telefone"),
          TextField(controller: telefone),
          Text("Matrícula"),
          TextField(controller: matricula),

          ElevatedButton(
            onPressed: () {
              if (nome.text != '' &&
                  telefone.text != '' &&
                  matricula.text != '') {
                //para voltar só se tudo for preenchido
                Aluno info = Aluno(
                  nome: nome.text,
                  telefone: telefone.text,
                  matricula: matricula.text,
                );

                //vai salvar o aluno no bd
                insert(info);


                Navigator.pop(context); //o pop é pra ir pra posição abaixo -> voltar (passando as informações)
              } else {
                debugPrint("Preencha todos os campos para continuar...");
              }
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }
}

class TelaAluno extends StatelessWidget {
  final Aluno aluno; //essa função recebe somente um aluno da tela inicial

  TelaAluno({required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(aluno.nome),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Image.asset("images/lara.png"),
          Text("Aluno: ${aluno.nome}"),
          Text("Tel.: ${aluno.telefone}"),
          Text("Matrícula: ${aluno.matricula}"),
        ],
      ),
    );
  }
}


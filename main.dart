import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Modelo para Experiência
class Experiencia {
  String empresa;
  String periodo;

  Experiencia({required this.empresa, required this.periodo});
}

// Modelo para Projeto
class Projeto {
  String titulo;
  String dataPublicacao;

  Projeto({required this.titulo, required this.dataPublicacao});
}

// Modelo para Escolaridade
class Escolaridade {
  String instituicao;
  String curso;

  Escolaridade({required this.instituicao, required this.curso});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo de Perfil',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PerfilScreen(),
    );
  }
}

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'images/fotoperfil.jpeg',
              ), // Placeholder de avatar
            ),
            const SizedBox(height: 20),
            const Text(
              'Maria Bernardes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExperienciaScreen(),
                  ),
                );
              },
              child: const Text('Experiência'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProjetosScreen(),
                  ),
                );
              },
              child: const Text('Projetos'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EscolaridadeScreen(),
                  ),
                );
              },
              child: const Text('Escolaridade'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienciaScreen extends StatefulWidget {
  const ExperienciaScreen({super.key});

  @override
  State<ExperienciaScreen> createState() => _ExperienciaScreenState();
}

class _ExperienciaScreenState extends State<ExperienciaScreen> {
  final List<Experiencia> _experiencias = [
    Experiencia(empresa: 'redatora', periodo: '2025 - presente'),
    Experiencia(empresa: 'maquiadora', periodo: '2023 - presente'),
    Experiencia(empresa: 'manicure', periodo: '2025 - presente'),
  ];

  void _adicionarExperiencia() {
    setState(() {
      _experiencias.add(
        Experiencia(empresa: 'Nova Empresa', periodo: '2023 - Presente'),
      );
    });
  }

  void _removerExperiencia(int index) {
    setState(() {
      _experiencias.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experiência')),
      body: ListView.builder(
        itemCount: _experiencias.length,
        itemBuilder: (context, index) {
          final experiencia = _experiencias[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(experiencia.empresa),
              subtitle: Text(experiencia.periodo),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removerExperiencia(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarExperiencia,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProjetosScreen extends StatefulWidget {
  const ProjetosScreen({super.key});

  @override
  State<ProjetosScreen> createState() => _ProjetosScreenState();
}

class _ProjetosScreenState extends State<ProjetosScreen> {
  final List<Projeto> _projetos = [
    Projeto(titulo: 'Visux', dataPublicacao: '2025-09-10'),
    Projeto(titulo: 'HydroSense', dataPublicacao: '2026-04-14'),
  ];

  void _adicionarProjeto() {
    setState(() {
      _projetos.add(
        Projeto(titulo: 'Novo Projeto', dataPublicacao: '2024-04-20'),
      );
    });
  }

  void _removerProjeto(int index) {
    setState(() {
      _projetos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projetos')),
      body: ListView.builder(
        itemCount: _projetos.length,
        itemBuilder: (context, index) {
          final projeto = _projetos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(projeto.titulo),
              subtitle: Text(projeto.dataPublicacao),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removerProjeto(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarProjeto,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EscolaridadeScreen extends StatefulWidget {
  const EscolaridadeScreen({super.key});

  @override
  State<EscolaridadeScreen> createState() => _EscolaridadeScreenState();
}

class _EscolaridadeScreenState extends State<EscolaridadeScreen> {
  final List<Escolaridade> _escolaridades = [
    Escolaridade(instituicao: 'IFC', curso: 'Medicina Veterinária'),
    Escolaridade(
      instituicao: 'Instituto Federal Catarinense campus - Concórdia',
      curso: 'Técnico em Informática para internet',
    ),
  ];

  void _adicionarEscolaridade() {
    setState(() {
      _escolaridades.add(
        Escolaridade(instituicao: 'Nova Instituição', curso: 'Novo Curso'),
      );
    });
  }

  void _removerEscolaridade(int index) {
    setState(() {
      _escolaridades.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escolaridade')),
      body: ListView.builder(
        itemCount: _escolaridades.length,
        itemBuilder: (context, index) {
          final escolaridade = _escolaridades[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(escolaridade.instituicao),
              subtitle: Text(escolaridade.curso),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removerEscolaridade(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarEscolaridade,
        child: const Icon(Icons.add),
      ),
    );
  }
}

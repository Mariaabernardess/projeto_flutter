import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

/// Classe principal do aplicativo
class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Perfil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TelaPerfil(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Tela 1: Perfil do Usuário
class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar grande centralizado
            const CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                'images/eukkk.jpeg',
              ),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            
            // Nome do usuário
            const Text(
              'Maria Bernardes',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            
            // Botão Experiência
            ElevatedButton(
              onPressed: () {
                // Navegação para a Tela 2 (Experiência)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaExperiencia()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Experiência', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 15),
            
            // Botão Projetos (Sem ação definida no requisito)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Projetos', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 15),
            
            // Botão Escolaridade (Sem ação definida no requisito)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Escolaridade', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modelo de Dados para Experiência
class Experiencia {
  String empresa;
  String periodo;

  Experiencia({required this.empresa, required this.periodo});
}

/// Tela 2: Experiência
class TelaExperiencia extends StatefulWidget {
  const TelaExperiencia({super.key});

  @override
  State<TelaExperiencia> createState() => _TelaExperienciaState();
}

class _TelaExperienciaState extends State<TelaExperiencia> {
  // Lista inicial de experiências
  final List<Experiencia> _experiencias = [
    Experiencia(empresa: 'Visux', periodo: '2025 - 2025'),
    Experiencia(empresa: 'HydroSense', periodo: '2026 - 2026'),
  ];

  // Controladores para os campos de texto ao adicionar nova experiência
  final TextEditingController _empresaController = TextEditingController();
  final TextEditingController _periodoController = TextEditingController();

  /// Função para remover uma experiência da lista
  void _removerExperiencia(int index) {
    setState(() {
      _experiencias.removeAt(index);
    });
  }

  /// Função para exibir o modal de adicionar nova experiência
  void _mostrarDialogoAdicionar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nova Experiência'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _empresaController,
                decoration: const InputDecoration(labelText: 'Nome da Empresa'),
              ),
              TextField(
                controller: _periodoController,
                decoration: const InputDecoration(labelText: 'Período (ex: 2023 - 2024)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal sem salvar
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_empresaController.text.isNotEmpty && _periodoController.text.isNotEmpty) {
                  setState(() {
                    // Adiciona a nova experiência na lista
                    _experiencias.add(
                      Experiencia(
                        empresa: _empresaController.text,
                        periodo: _periodoController.text,
                      ),
                    );
                  });
                  // Limpa os campos
                  _empresaController.clear();
                  _periodoController.clear();
                  Navigator.of(context).pop(); // Fecha o modal
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Limpa os controladores quando a tela for destruída
    _empresaController.dispose();
    _periodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiência'),
      ),
      body: _experiencias.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma experiência adicionada.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _experiencias.length,
              itemBuilder: (context, index) {
                final exp = _experiencias[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.work),
                    ),
                    title: Text(
                      exp.empresa,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(exp.periodo),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removerExperiencia(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAdicionar,
        tooltip: 'Adicionar Experiência',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PaginaInicial(),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final List<String> imagens = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Kibale_chimp.jpg/500px-Kibale_chimp.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/500px-Cat03.jpg',
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/11/Cc-by_new_white.svg/960px-Cc-by_new_white.svg.png?utm_source=pt.wikipedia.org&utm_campaign=imageinfo&utm_content=thumbnail',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Google-flutter-logo.png/500px-Google-flutter-logo.png',
  ];

  final List<String> aprovadas = [];

  Future<void> abrirImagem(String imagem) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PaginaImagem(imagem: imagem),
      ),
    );

    if (resultado == true) {
      setState(() {
        if (!aprovadas.contains(imagem)) {
          aprovadas.add(imagem);
        }
      });
    }
  }

  void abrirAprovadas() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaginaAprovadas(
          imagens: aprovadas,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagens da Wikipedia'),
        actions: [
          IconButton(
            onPressed: abrirAprovadas,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: imagens.map((imagem) {
            return GestureDetector(
              onTap: () {
                abrirImagem(imagem);
              },
              child: Image.network(
                imagem,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PaginaImagem extends StatelessWidget {
  final String imagem;

  const PaginaImagem({
    super.key,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliar imagem'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imagem,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Aprovar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Reprovar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaAprovadas extends StatelessWidget {
  final List<String> imagens;

  const PaginaAprovadas({
    super.key,
    required this.imagens,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagens aprovadas'),
      ),
      body: imagens.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma imagem aprovada.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.all(10),
              children: imagens.map((imagem) {
                return Image.network(
                  imagem,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
    );
  }
}

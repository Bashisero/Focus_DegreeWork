import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showInfoDialog(context),
          child: const Text('Mostrar Info'),
        ),
      ),
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 300, // Ajusta según tu contenido
            width: double.maxFinite,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 4, // Número total de páginas
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                // Aquí devuelves el contenido de cada página
                return Center(
                  child: Text('Contenido de la página $index'),
                );
              },
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) { // Genera los indicadores
                return Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                );
              }),
            ),
            TextButton(
              onPressed: () {
                if (_currentPage < 3) {
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.of(context).pop(); // Todos los pop-ups han sido vistos
                }
              },
              child: const Text('Siguiente'),
            ),
          ],
        );
      },
    ).then((_) => null);
  }
}
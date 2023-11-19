import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/lluvia.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/flowtime.dart';
import 'package:tesis/models.dart';
import 'package:tesis/pomodoro.dart';
import 'package:tesis/projects.dart';
import 'package:tesis/tools.dart';
import 'descansoPom.dart';

//
int tomates = 0;
int rondas = 0;
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => AppDatabase()),
        ChangeNotifierProvider(create: (context) => ProyectoModel()),
        ChangeNotifierProvider(create: (context) => IdeasState()),
        ChangeNotifierProvider(
            create: (context) => TareaModel()), // Agregado para TareaModel
        // Otros providers, si los tienes
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        routes: {
          '/descansoPom': (context) => const DescansoPom(),
          '/pomodoro': (context) => const Pomodoro(),
          '/flowtime': (context) => const FlowTime(),
          '/proyectos': (context) => const Projects(),
          '/lluvia': (context) => const Ideas(),
          '/tools': (context) => const Tools(),
        },

        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false, // Remove the debug banner
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF356D64)),
          primaryColor: const Color(0xFF22142b),
          cardTheme: const CardTheme(
            color: Color(0xFFF8ECE0),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFAF5F1),
        ),
        home: const MyHomePage(title: 'Hola'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  // ignore: unused_field
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void showInfoDialog(BuildContext context) {
    _currentPage = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const InfoDialogContent();
      },
    ).then((_) {
      // Restablece el _currentPage cuando el diálogo se cierre
      setState(() {
        _currentPage = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/pomodoro');
                        },
                        child: Image.asset('assets/pomodoroButton.png', height: 100, width: 100),
                      ),
                      InkWell(
                        // Botón FlowTime
                        onTap: () {
                          Navigator.pushNamed(context, '/flowtime');
                        },
                        child: Image.asset('assets/flowTimeButton.png', height: 95, width: 95)
                      )
                    ]),
                ElevatedButton(
                  // Botón Proyectos
                  onPressed: () {
                    Navigator.pushNamed(context, '/proyectos');
                  },
                  child: const Text("Proyectos"),
                ),
                ElevatedButton(
                  // Botón Logros
                  onPressed: () {
                    Navigator.pushNamed(context, '/lluvia');
                  },
                  child: const Text("Lluvia"),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 470,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 15, 182, 182),
                  shape: BoxShape.circle),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  showInfoDialog(context);
                },
                iconSize: 38,
                icon: const Icon(Icons.info_outline_rounded),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 100,
            child: Image.asset(
              'assets/tablero.png',
              height: 150,
              width: 400,
            ),
          ),
          Positioned(
            right: 270,
            bottom: 60,
            child: Image.asset('assets/wombatTablero.png',
                height: 110, width: 100),
          ),
        ],
      ),
    );
  }
}

class InfoDialogContent extends StatefulWidget {
  const InfoDialogContent({Key? key}) : super(key: key);

  @override
  InfoDialogContentState createState() => InfoDialogContentState();
}

class InfoDialogContentState extends State<InfoDialogContent> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Define una lista de widgets que representen el contenido de cada página.
  final List<Widget> _pagesContent = [
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bienvenido a [...]'),
        Text('Esta aplicación está pensada para ...'),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Conoces la técnica Pomodoro?'),
        Text(
            'Pomodoro se trata de una técnica para [...], funciona de forma que [...]'),
        Text('¿Qué tal si le echas un vistazo?'),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Conoces la(te) herramienta FlowTime?'),
        Text(
            'FlowTime se trata de una(te) herramienta para [...], funciona de forma que [...]'),
        Text('¿Cómo funciona?'),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Obando es Gay'),
      ],
    )
    // Agrega más Widgets para las otras páginas siguiendo la misma estructura.
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 300, // Ajusta según tu contenido
        width: double.maxFinite,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _pagesContent.length, // Número total de páginas
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            // Devuelve el widget de contenido correspondiente al índice actual
            return _pagesContent[index];
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_pagesContent.length, (index) {
            // Genera los indicadores
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
              _pageController.nextPage(
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
  }
}

const TextStyle estiloHistoriales =
    TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold);

const TextStyle estiloTitulos =
    TextStyle(fontSize: 24, color: Colors.black54, fontWeight: FontWeight.bold);

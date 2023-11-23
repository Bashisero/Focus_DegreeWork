import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/consejos.dart';
import 'package:tesis/lluvia.dart';
import 'package:tesis/drift_database.dart';
import 'package:tesis/flowtime.dart';
import 'package:tesis/models.dart';
import 'package:tesis/pomodoro.dart';
import 'package:tesis/projects.dart';

//
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
    return FeatureDiscovery(
      child: MaterialApp(
        routes: {
          '/pomodoro': (context) => const Pomodoro(),
          '/flowtime': (context) => const FlowTime(),
          '/proyectos': (context) => const Projects(),
          '/lluvia': (context) => const Ideas(),
        },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF356D64)),
          primaryColor: const Color(0xFF22142b),
          cardTheme: const CardTheme(
            color: Color(0xFFF8ECE0),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFAF5F1),
        ),
        home: const MyHomePage(title: 'ZenTasker'),
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
  String consejoAleatorio = '';
  // ignore: unused_field
  int _currentPage = 0;
  bool tutorialShown = false;

  @override
  void initState() {
    FeatureDiscovery.discoverFeatures(
      context,
      <String>{
        'pomodoroId',
        'flowtimeId',
        'proyectosId',
        'lluviaId',
        'infoId'
      }, // IDs de las características que quieres mostrar.
    );
    consejoAleatorio = ConsejosProvider.obtenerConsejoAleatorio();
    super.initState();
  }

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
        return Dialog(
          // Cambia AlertDialog por Dialog para más control
          alignment: Alignment.center, // Esto centra el Dialog en la pantalla
          child: SingleChildScrollView(
            // Asegúrate de que el contenido pueda desplazarse
            child: Container(
              // Envuelve en un Container para dar un tamaño específico si es necesario
              width: MediaQuery.of(context).size.width * 0.95,
              padding: const EdgeInsets
                  .only(), // Añade padding alrededor del contenido del diálogo // por ejemplo, el 80% del ancho de la pantalla
              child: const InfoDialogContent(),
            ),
          ),
        );
      },
    ).then((_) {
      setState(() {
        _currentPage = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double infoButtonBottomPosition = screenSize.height * 0.57;
    double infoButtonRightPosition = screenSize.width * 0.05;

    double tableroBottomPosition = screenSize.height * 0.1;
    double tableroRightPosition = screenSize.width * -0.03;

    double wombatBottomPosition = screenSize.height * 0.05;
    double wombatRightPosition = screenSize.width * 0.68;
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
                      DescribedFeatureOverlay(
                        featureId: 'pomodoroId',
                        title: const Text('Técnica Pomodoro'),
                        backgroundColor: Theme.of(context).primaryColor,
                        backgroundOpacity: 0.8,
                        targetColor: Colors.white,
                        textColor: Colors.white,
                        contentLocation: ContentLocation.below,
                        overflowMode: OverflowMode.extendBackground,
                        description: const Text(
                          'Pomodoro te permite trabajar usando sesiones de tiempos establecidos con descansos periódicos fijos',
                        ),
                        tapTarget: Image.asset('assets/wombatTomate.png'),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/pomodoro').then((_) {
                              setState(() {
                                consejoAleatorio =
                                    ConsejosProvider.obtenerConsejoAleatorio();
                              });
                            });
                          },
                          child: Image.asset('assets/pomodoroButton.png',
                              height: 100, width: 100),
                        ),
                      ),
                      DescribedFeatureOverlay(
                        featureId: 'flowtimeId',
                        title: const Text('Técnica Flowtime'),
                        backgroundColor: Theme.of(context).primaryColor,
                        targetColor: Colors.white,
                        textColor: Colors.white,
                        overflowMode: OverflowMode.extendBackground,
                        backgroundOpacity: 0.8,
                        contentLocation: ContentLocation.below,
                        tapTarget: Image.asset('assets/wombatFlow.png'),
                        description: const Text(
                          'FlowTime te permite trabajar indefinidamente enfocado en una sola tarea, basándose en la teoría del flujo, donde le das rienda suelta a tu capacidad de enfocarte en algo sin noción de tiempo',
                        ),
                        child: InkWell(
                            // Botón FlowTime
                            onTap: () {
                              Navigator.pushNamed(context, '/flowtime')
                                  .then((_) {
                                setState(() {
                                  consejoAleatorio = ConsejosProvider
                                      .obtenerConsejoAleatorio();
                                });
                              });
                            },
                            child: Image.asset('assets/flowTimeButton.png',
                                height: 95, width: 95)),
                      )
                    ]),
                DescribedFeatureOverlay(
                  featureId: 'proyectosId',
                  title: const Text('Proyectos'),
                  backgroundColor: Theme.of(context).primaryColor,
                  targetColor: Colors.white,
                  textColor: Colors.white,
                  overflowMode: OverflowMode.extendBackground,
                  backgroundOpacity: 0.8,
                  tapTarget: Image.asset('assets/wombatProyectos.png'),
                  description: const Text(
                    '¿No es mejor tener tus actividades anotadas y distribuidas?, aquí puedes tener proyectos divididos en tareas',
                  ),
                  child: ElevatedButton(
                      // Botón Proyectos
                      onPressed: () {
                        Navigator.pushNamed(context, '/proyectos').then((_) {
                          setState(() {
                            consejoAleatorio =
                                ConsejosProvider.obtenerConsejoAleatorio();
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: 5),
                      child: const Text("Proyectos")),
                ),
                DescribedFeatureOverlay(
                  featureId: 'lluviaId',
                  title: const Text('Lluvia de Ideas'),
                  backgroundColor: Theme.of(context).primaryColor,
                  targetColor: Colors.white,
                  textColor: Colors.white,
                  overflowMode: OverflowMode.extendBackground,
                  backgroundOpacity: 0.8,
                  tapTarget: Image.asset('assets/wombatIdeas.png'),
                  description: const Text(
                    'La clásica lluvia de ideas, en este apartado puedes filtrar qué ideas que se te vienen a la mente te gustan... Y cuáles quizá no tanto',
                  ),
                  child: ElevatedButton(
                    // Botón Logros
                    onPressed: () {
                      Navigator.pushNamed(context, '/lluvia').then((_) {
                        setState(() {
                          consejoAleatorio =
                              ConsejosProvider.obtenerConsejoAleatorio();
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 5),
                    child: const Text("Lluvia"),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          Positioned(
            right: infoButtonRightPosition,
            bottom: infoButtonBottomPosition,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  color: Color(0xFFFAF5F1), shape: BoxShape.circle),
              child: DescribedFeatureOverlay(
                featureId: 'infoId',
                title: const Text('Información'),
                overflowMode: OverflowMode.extendBackground,
                backgroundOpacity: 0.8,
                backgroundColor: Theme.of(context).primaryColor,
                targetColor: Colors.white,
                textColor: Colors.white,
                tapTarget: Image.asset('assets/wombatInfo.png'),
                description: const Text(
                  'Aquí puedes encontrar información detallada, en caso de que se te olvide algo de lo dicho en este tutorial',
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    showInfoDialog(context);
                  },
                  style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 5),
                  iconSize: 38,
                  icon: const Icon(Icons.info_outline_rounded),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Positioned(
              right: tableroRightPosition,
              bottom: tableroBottomPosition,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/tablero.png',
                    height: 150,
                    width: 400,
                  ),
                  Container(
                      width: 270,
                      height: 80, // Ajusta la anchura según tu imagen
                      padding: const EdgeInsets.all(
                          0), // Añade un poco de espacio alrededor del texto
                      child: Text(
                        consejoAleatorio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors
                                .black, // Asegúrate de que el color contraste bien con tu imagen
                            fontSize: 13,
                            fontWeight: FontWeight
                                .bold // Ajusta el tamaño del texto como prefieras
                            ),
                      ))
                ],
              )),
          Positioned(
            right: wombatRightPosition,
            bottom: wombatBottomPosition,
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
    const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Bienvenido a ZenTasker',
                  style: estiloTitulos, textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
                'Esta aplicación está pensada para brindar un espacio en el que cuentes con ciertas herramientas para propiciar hábitos con los que mejorar tu efectividad al momento de estudiar, trabajar, o llevar a cabo algo de tu interés. Tales como Pomodoro, Flowtime, registros de tus tareas, y registros de tus sesiones realizadas',
                textAlign: TextAlign.center),
          ),
        ],
      ),
    ),
    const SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            '¿Te cuesta enfocarte en tareas extensas?',
            style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                height: 1),
            textAlign: TextAlign.center,
          )),
          Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                  "Pomodoro te permite trabajar usando sesiones de tiempos establecidos con descansos periódicos fijos. Aquí podrás realizar tareas anonimas de Pomodoro y ver el historial de las sesiones que has hecho")),
        ],
      ),
    ),
    const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Déjate llevar',
                  style: estiloTitulos, textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
            child: Text(
                'FlowTime se basa en la teoría del flujo, la cual consiste en esos momentos en los que estás absorbido por una actividad en concreta y pierdes incluso la noción del tiempo, pudiendo desenvolverte en esto indefinidamente. Tiene un enfoque mayormente enfocado a tareas de creativas, de análisis, y resolución de problemas, Aquí podrás realizar tareas anonimas de Flowtime y ver el historail de las sesiones que has hecho, así como registrar las interrupciones que hayas tenido en media sesión'),
          ),
        ],
      ),
    ),
    const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Organiza tus actividades',
                  style: estiloTitulos, textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
            child: Text(
                'Llevar un control visual de tus pendientes, sea trabajo o proyectos personales, es una gran forma de empezar a visualizar tu progreso, tu rendimiento, ¡E incluso tu motivación para hacer algo!. Aquí puedes registrarlas, además de poder realizarlas directamente con cualquiera de ambas técnicas.'),
          ),
        ],
      ),
    ),
    const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text('Parece que quiere llover...',
                  style: estiloTitulos, textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
            child: Text(
                '¿Necesitas dar en el blanco con alguna idea? Puedes dejar libre cualquiera que se te ocurra y filtrarlas cuanto se te antojen, hasta que des con la(s) correcta(s)'),
          )
        ],
      ),
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
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _pagesContent.length, // Número total de páginas
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (context, index) {
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

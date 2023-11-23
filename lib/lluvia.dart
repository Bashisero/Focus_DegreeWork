import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lluvia extends StatelessWidget {
  const Lluvia({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdeasState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
      ),
    );
  }
}

class IdeasState extends ChangeNotifier {
  var current = '';
  var history = <String>[];

  GlobalKey? historyListKey;

  void addUserInputToHistory(String userInput, bool addToFavorites) {
    if (userInput.isNotEmpty) {
      history.insert(0, userInput);
      var animatedList = historyListKey?.currentState as AnimatedListState?;
      animatedList?.insertItem(0);

      if (addToFavorites) {
        if (!favorites.contains(userInput)) {
          favorites.add(userInput);
        } else {
          favorites.remove(userInput);
        }
      }
      notifyListeners();
    }
  }

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = ''; // Actualizar para que sea un String
    notifyListeners();
  }

  var favorites = <String>[];
  var discarded = <String>[];

  void addDiscarded(String item) {
    if (item.isNotEmpty && !discarded.contains(item)) {
      discarded.add(item);
      notifyListeners();
    }
  }

  void removeDiscarded(String item) {
    discarded.remove(item);
    notifyListeners();
  }

  void toggleFavorite(String item) {
    if (favorites.contains(item)) {
      favorites.remove(item);
    } else {
      favorites.add(item);
    }
    notifyListeners();
  }

  void removeFavorite(String pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}

class Ideas extends StatefulWidget {
  const Ideas({super.key});

  @override
  State<Ideas> createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = const FavoritesPage();
        break;
      case 2:
        page = const Descartadas();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: const Text("Filtra tus ideas",
            style: TextStyle(color: Color(0xFFFAF5F1))),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 450) {
                return Column(
                  children: [
                    Expanded(child: mainArea),
                    SafeArea(
                      child: BottomNavigationBar(
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.lightbulb_outline_rounded),
                            label: 'Idear',
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.sticky_note_2_outlined),
                              label: 'Ideas Generales'),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.favorite),
                            label: 'Ideas Potenciales',
                          ),
                        ],
                        currentIndex: selectedIndex,
                        onTap: (value) {
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                      ),
                    )
                  ],
                );
              } else {
                return Row(
                  children: [
                    SafeArea(
                      child: NavigationRail(
                        extended: constraints.maxWidth >= 600,
                        destinations: const [
                          NavigationRailDestination(
                            icon: Icon(Icons.home),
                            label: Text('Home'),
                          ),
                          NavigationRailDestination(
                              icon: Icon(Icons.sticky_note_2_outlined),
                              label: Text('Ideas Generales')),
                          NavigationRailDestination(
                            icon: Icon(Icons.favorite),
                            label: Text('Ideas Potenciales'),
                          ),
                        ],
                        selectedIndex: selectedIndex,
                        onDestinationSelected: (value) {
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                      ),
                    ),
                    Expanded(child: mainArea),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  GeneratorPage({Key? key}) : super(key: key);

  final textController = TextEditingController(); // Controlador de texto

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<IdeasState>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          const SizedBox(height: 10),
          BigCard(controller: textController),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  appState.addUserInputToHistory(textController.text, false);
                  appState.addDiscarded(textController.text);
                  textController.clear();
                },
                child: const Text('Siguiente...'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.addUserInputToHistory(textController.text, true);
                  textController.clear();
                },
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Para que el Row no ocupe todo el ancho disponible
                  children: <Widget>[
                    Icon(
                      appState.favorites.contains(textController.text)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    const SizedBox(
                        width: 4), // Espacio entre el ícono y el texto
                    const Text("Me gusta"),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Positioned(
              right: MediaQuery.of(context).size.width * 0.41,
              bottom: MediaQuery.of(context).size.height * 0.075,
              child: Image.asset('assets/wombatL.png', height: 85, width: 85))
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.controller, // Añadir un TextEditingController
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white), // Estilo del texto
          decoration: const InputDecoration(
            hintText: "Escribe aquí",
            hintStyle:
                TextStyle(color: Colors.white60), // Estilo del placeholder
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<IdeasState>();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: appState.discarded.length,
            itemBuilder: (context, index) {
              final item = appState.discarded[index];
              return ListTile(
                title: Text(item,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        appState.removeDiscarded(item);
                        appState.toggleFavorite(item);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        appState.removeDiscarded(item);
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
        Positioned(
            right: MediaQuery.of(context).size.width * 0.41,
            bottom: MediaQuery.of(context).size.height * 0.075,
            child: Image.asset('assets/wombatDescartada.png', height: 85, width: 85))
      ],
    );
  }
}

class Descartadas extends StatelessWidget {
  const Descartadas({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<IdeasState>();

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: appState.favorites.length,
            itemBuilder: (context, index) {
              final item = appState.favorites[index];
              return ListTile(
                title: Text(item,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    appState.removeFavorite(item);
                    appState.addDiscarded(item);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
        Positioned(
            right: MediaQuery.of(context).size.width * 0.41,
            bottom: MediaQuery.of(context).size.height * 0.075,
            child: Image.asset('assets/wombatIdea.png', height: 85, width: 85))
      ],
    );
  }
}

class HistoryListView extends StatefulWidget {
  const HistoryListView({Key? key}) : super(key: key);

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  /// Needed so that [MyAppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    // This gradient goes from fully transparent to fully opaque black...
    colors: [Colors.transparent, Colors.black],
    // ... from the top (transparent) to half (0.5) of the way to the bottom.
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<IdeasState>();
    appState.historyListKey = _key;

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient)
      // and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final item = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  appState.toggleFavorite(item);
                },
                icon: appState.favorites.contains(item)
                    ? const Icon(Icons.favorite, size: 12)
                    : const SizedBox(),
                label: Text(
                  item,
                  semanticsLabel: item,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

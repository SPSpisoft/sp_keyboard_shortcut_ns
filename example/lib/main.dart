import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sp_keyboard_shortcut_ns/sp_keyboard_shortcut_ns.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.list),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondPage()),
          ),
        ),
      ),
      body: KeyBoardShortcuts(
        keysToPress: {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyP},
        onKeysPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondPage()),
        ),
        helpLabel: "Go to Second Page",
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              KeyBoardShortcuts(
                keysToPress: {LogicalKeyboardKey.backspace},
                onKeysPressed: _decrementCounter,
                child: KeyBoardShortcuts(
                  keysToPress: {LogicalKeyboardKey.keyA},
                  onKeysPressed: _incrementCounter,
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: KeyBoardShortcuts(
        keysToPress: shortCut(BasicShortCuts.creation),
        onKeysPressed: _incrementCounter,
        helpLabel: "Increment",
        child: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );

  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> generatedList = List<String>.generate(100, (counter) => "Item $counter");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: KeyBoardShortcuts(keysToPress: shortCut(BasicShortCuts.esc),
        globalShortcuts: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: generatedList.length,
                  itemBuilder: (BuildContext ctxt, int index) => Center(
                    child: Text(generatedList[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

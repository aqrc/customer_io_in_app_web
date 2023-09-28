import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(deepness: 1),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int deepness;

  const MyHomePage({super.key, required this.deepness});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $deepness'),
      ),
      body: Center(
        child: Text('Page $deepness'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nextDeepness = deepness + 1;
          Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(name: 'page$nextDeepness'),
            builder: (context) {
              return MyHomePage(deepness: nextDeepness);
            },
          ));
        },
        tooltip: 'New Page',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

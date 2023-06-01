import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speezer App',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            labelMedium: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            titleMedium: TextStyle(color: Colors.deepPurple),
            titleLarge: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          )),
      home: const MyHomePage(title: 'Speezer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        leadingWidth: 10,
      ),
      body: Center(
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 500,
              child: NavigationRail(
                backgroundColor: Theme.of(context).primaryColor,
                selectedIndex: 0,
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(
                        Icons.favorite,
                        size: 25,
                        color: Colors.black,
                      ),
                      label: Text("Favoriter")),
                  NavigationRailDestination(
                      icon: Icon(
                        Icons.favorite,
                        size: 25,
                        color: Colors.black,
                      ),
                      label: Text("Favoriter"))
                ],
              ),
            ),
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

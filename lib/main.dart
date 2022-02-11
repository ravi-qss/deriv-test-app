import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

/// The main widget.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomeApp());
}



import 'package:flutter/material.dart';

class EntryLevelPage extends StatefulWidget {
  const EntryLevelPage({Key? key}) : super(key: key);

  @override
  State<EntryLevelPage> createState() => _EntryLevelPageState();
}

class _EntryLevelPageState extends State<EntryLevelPage> {

  @override
  //create a simple widget with a text center that says entrypage
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Entry Page'),
      ),
    );
  }
}

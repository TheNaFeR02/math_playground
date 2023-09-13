

import 'package:flutter/material.dart';

class ProblemsPage extends StatefulWidget {
  const ProblemsPage({Key? key}) : super(key: key);

  @override
  State<ProblemsPage> createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {

  @override
  //create a simple widget with a text center that says entrypage
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Problems Page'),
      ),
    );
  }
}

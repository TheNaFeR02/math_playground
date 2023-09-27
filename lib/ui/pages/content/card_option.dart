import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_playground/ui/pages/content/problems_page.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({super.key, required this.operationSession});

  final String operationSession;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
            Get.to(ProblemsPage(operationSession: operationSession));
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(child: Text(operationSession)),
          ),
        ),
      ),
    );
  }
}

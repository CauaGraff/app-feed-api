import 'package:flutter/material.dart';

class ESContainer extends StatelessWidget {
  final List<Widget> widgets;

  const ESContainer({super.key, required this.widgets});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start, children: widgets));
  }
}

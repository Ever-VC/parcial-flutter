import 'package:control_gastos/presentation/widgets/main_nav.dart';
import 'package:flutter/material.dart';

class ContentBox extends StatefulWidget {
  const ContentBox({super.key});

  @override
  State<ContentBox> createState() => _ContentBoxState();
}

class _ContentBoxState extends State<ContentBox> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: MainNavigtion(),
    );
  }
}
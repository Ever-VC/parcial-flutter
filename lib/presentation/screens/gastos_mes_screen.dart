import 'package:flutter/material.dart';

class GastosMesScreen extends StatefulWidget {
  const GastosMesScreen({super.key});

  @override
  State<GastosMesScreen> createState() => _GastosMesScreenState();
}

class _GastosMesScreenState extends State<GastosMesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gastos por mes"),
      ),
    );
  }
}
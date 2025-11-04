import 'package:control_gastos/presentation/screens/gastos_mes_screen.dart';
import 'package:control_gastos/presentation/screens/gastos_screen.dart';
import 'package:control_gastos/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainNavigtion extends StatefulWidget {
  const MainNavigtion({super.key});

  @override
  State<MainNavigtion> createState() => _MainNavigtionState();
}

class _MainNavigtionState extends State<MainNavigtion> {
  final lstScreens = [GastosScreen(), HomeScreen(), GastosMesScreen()];
  int selScreenIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selScreenIndex,
        children: lstScreens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selScreenIndex,
        onTap: (value) {
          setState(() {
            selScreenIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Gastos',
            icon: Icon(Icons.shopping_basket_outlined),
            activeIcon: Icon(Icons.shopping_basket)
          ),
          BottomNavigationBarItem(
            label: 'Inicio',
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            label: 'Gastos Mes',
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_month_rounded)
          ),
        ]
      ),
    );
  }
}
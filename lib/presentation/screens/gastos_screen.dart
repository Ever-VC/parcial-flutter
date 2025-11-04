import 'package:control_gastos/models/gasto.dart';
import 'package:control_gastos/presentation/screens/gasto_form.dart';
import 'package:control_gastos/providers/gasto_provider.dart';
import 'package:flutter/material.dart';

class GastosScreen extends StatefulWidget {
  const GastosScreen({super.key});

  @override
  State<GastosScreen> createState() => _GastosScreenState();
}

class _GastosScreenState extends State<GastosScreen> {
  List<Gasto> lstGastos = [];
  bool isTimeOut = false;
  final GastoProvider gastoProvider = GastoProvider();

  Future<void> _cargarGastos() async {
    var data = await gastoProvider.getGastos();
    if (data.isNotEmpty) {
      setState(() {
        lstGastos = data;
        isTimeOut = false;
      });
    } else {
      await Future.delayed(Duration(seconds: 4));
      setState(() {
        isTimeOut = true;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _cargarGastos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gastos"),
      ),
      body: Column(
        children: [
          Text("LISTADO DE GASTOS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          lstGastos.isEmpty
          ? (isTimeOut
            ? Center(child: Text("No hay registro de gastos", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.deepOrange)),)
            : Center(child: CircularProgressIndicator(),))
          : Expanded(
            child: ListView.builder(
              itemCount: lstGastos.length,
              itemBuilder: (context, index) {
                final gasto = lstGastos[index];
                return ListTile(
                  title: Text("Monto: \$${gasto.monto}"),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Fecha: ${gasto.fecha}"),
                      Text("Descripcion: ${gasto.descripcion}")
                    ],
                  ),
                  leading: Icon(Icons.shopify_sharp, color: Colors.deepOrange,),
                );
              },
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'gasto_fab',
        child: Icon(Icons.add_box_outlined),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GastoForm()));
          _cargarGastos();
        },
      ),
    );
  }
}
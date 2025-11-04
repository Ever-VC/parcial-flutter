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

  double gastoTotal() {
    double gastoTotal = lstGastos.fold(0.0, (suma, gasto) => suma + gasto.monto);
    return gastoTotal;
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
                  trailing: GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => GastoForm(gasto: gasto,)));
                      _cargarGastos();
                    },
                    child: Icon(Icons.edit_document),
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          icon: Icon(Icons.warning_rounded, color: Colors.deepOrange[900],),
                          title: Text('Atención:'),
                          content: Text("Esta seguro que desea eliminar el registro?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              }, 
                              child: Text("No")
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                gastoProvider.eliminarGasto(gasto.id ?? 0);
                                _cargarGastos();
                              }, 
                              child: Text("Sí")
                            ),
                          ],
                        );
                      }
                    );
                  },
                );
              },
            )
          ),
          SizedBox(height: 30,),
          Text("Cantidad total de gastos: \$${gastoTotal()}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'gasto_fab',
        child: Icon(Icons.add_box_outlined),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => GastoForm()));
          _cargarGastos();
        },
      ),
    );
  }
}
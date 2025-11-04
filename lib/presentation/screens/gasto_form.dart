import 'package:control_gastos/models/gasto.dart';
import 'package:control_gastos/providers/gasto_provider.dart';
import 'package:flutter/material.dart';

class GastoForm extends StatefulWidget {
  final Gasto? gasto;
  const GastoForm({super.key, this.gasto});

  @override
  // ignore: no_logic_in_create_state
  State<GastoForm> createState() => _GastoFormState(gasto);
}

class _GastoFormState extends State<GastoForm> {
  final TextEditingController txtMonto = TextEditingController();
  final TextEditingController txtDescripcion = TextEditingController();
  final TextEditingController txtFecha = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Gasto? gastoEdit;
  String mensaje = 'Nuevo Gasto';
  final List<String> lstCategorias = ['Alimentacion', 'Transpornte', 'Entrenimiento'];
  String? categoriaSel;
  final GastoProvider gastoProvider = GastoProvider();

  _GastoFormState(this.gastoEdit);

  @override
  void initState() {
    super.initState();
    if (gastoEdit != null) {
      txtMonto.text = gastoEdit!.monto.toString();
      txtDescripcion.text = gastoEdit!.descripcion;
      txtFecha.text = gastoEdit!.fecha;
      mensaje = 'Editar Gasto';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mensaje),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Text("FORMULARIO DE ${mensaje.toUpperCase()}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue[900])),
            SizedBox(height: 30,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: txtMonto,
                    decoration: InputDecoration(
                      labelText: 'Monto del gasto',
                      icon: Icon(Icons.price_change_rounded, color: Colors.green,)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no debe ser vacío';
                      }
                      if (double.tryParse(value) == null) {
                        return 'El campo solo recibe valores enteros o decimales';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: txtDescripcion,
                    decoration: InputDecoration(
                      labelText: 'Descripción del gasto',
                      icon: Icon(Icons.book_rounded, color: Colors.blue[900],)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no debe ser vacío';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: txtFecha,
                    decoration: InputDecoration(
                      labelText: 'Fecha del gasto: año-mes-dia',
                      icon: Icon(Icons.calendar_month_rounded, color: Colors.deepOrange,)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no debe ser vacío';
                      }
                      if (DateTime.tryParse(value) == null) {
                        return 'El campo solo permite cone el formato: año-mes-dia';
                      }
                      print(DateTime.parse(value));
                      return null;
                    },
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Seleccione la categoria',
                      icon: Icon(Icons.category_rounded, color: Colors.purpleAccent,),
                      hint: Text("Seleccione una categoría...")
                    ),
                    items: lstCategorias.map((categoria) {
                      return DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria)
                      );
                    }).toList(), 
                    onChanged: (value) {
                      categoriaSel = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debe seleccionar la categoria.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            double monto = double.parse(txtMonto.text);
                            String descripcion = txtDescripcion.text;
                            String fecha = txtFecha.text;
                            String mssg = 'creado';
                            if (gastoEdit != null) {
                              mssg = 'actualizado';
                              gastoProvider.actualizarGasto(Gasto(id: gastoEdit!.id, monto: monto, categoria: categoriaSel!, descripcion: descripcion, fecha: fecha));
                            } else {
                              gastoProvider.insertarGasto(Gasto(monto: monto, categoria: categoriaSel!, descripcion: descripcion, fecha: fecha));
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.greenAccent[200],
                                content: ListTile(
                                  title: Text("Exito:"),
                                  subtitle: Text("El gasto de ${monto.toStringAsFixed(2)} se ha $mssg exitosamente"),
                                  leading: Icon(Icons.done, color: Colors.green[900],),
                                )
                              )
                            );
                          }
                        }, 
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.save_as_rounded, color: Colors.green[900],),
                            SizedBox(width: 10,),
                            Text("Guardar")
                          ],
                        )
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.close_rounded, color: Colors.red[900],),
                            SizedBox(width: 10,),
                            Text("Cancelar")
                          ],
                        )
                      )
                    ],
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
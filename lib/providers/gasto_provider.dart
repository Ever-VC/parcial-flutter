import 'package:control_gastos/database/db_conn.dart';
import 'package:control_gastos/models/gasto.dart';

class GastoProvider {
  SqliteConnection connection = SqliteConnection();

  Future<void> insertarGasto(Gasto gasto) async {
    final db = await connection.database;
    db.insert('gasto', gasto.toMap());
  }

  Future<void> eliminarGasto(int id) async {
    final db = await connection.database;
    db.delete('gasto', where: 'id=?', whereArgs: [id]);
  }

  Future<void> actualizarGasto(Gasto gastoActualizado) async {
    final db = await connection.database;
    db.update('gasto', gastoActualizado.toMap(), where: 'id=?', whereArgs: [gastoActualizado.id]);
  }

  Future<List<Gasto>> getGastos() async {
    final db = await connection.database;
    final List<Map<String, dynamic>> mapas = await db.query('gasto');
    return mapas.map((mapa) => Gasto.fromMap(mapa)).toList();
  }
}
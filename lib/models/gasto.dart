class Gasto {
  final int? id;
  final double monto;
  final String categoria;
  final String descripcion;
  final String fecha;

  Gasto({this.id, required this.monto, required this.categoria, required this.descripcion, required this.fecha});

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'monto': monto,
      'categoria': categoria,
      'descripcion': descripcion,
      'fecha': fecha  
    };
  }

  factory Gasto.fromMap(Map<String, dynamic> mapa) {
    return Gasto(
      id: mapa['id'] as int?,
      monto: mapa['monto'] as double, 
      categoria: mapa['categoria'] as String, 
      descripcion: mapa['descripcion'] as String, 
      fecha: mapa['fecha']  as String,
    );
  }

  @override
  String toString() => monto.toString();
}
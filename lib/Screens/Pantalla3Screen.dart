import 'package:ejercicios_04/navigation/Drawer.dart';
import 'package:flutter/material.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3({super.key});

  @override
  State<Pantalla3> createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {
  final TextEditingController _ahorroMensual = TextEditingController();
  final TextEditingController _cantidadMeses = TextEditingController();
  final TextEditingController _tasaInteres = TextEditingController();

  // Opción para usar o no interés mensual
  bool usarInteres = false;

  // Limpia los campos
  void limpiarCampos() {
    _ahorroMensual.clear();
    _cantidadMeses.clear();
    _tasaInteres.clear();
    setState(() {
      usarInteres = false;
    });
  }

  // Valida que un texto sea número positivo
  bool esNumeroPositivo(String valor) {
    if (valor.isEmpty) return false;
    final numero = double.tryParse(valor);
    if (numero == null || numero <= 0) return false;
    return true;
  }

  // Cálculo del ahorro total y detalle mes a mes
  Map<String, dynamic>? calcularAhorro() {
    if (!esNumeroPositivo(_ahorroMensual.text) || !esNumeroPositivo(_cantidadMeses.text)) {
      return null;
    }
    double ahorroMensual = double.parse(_ahorroMensual.text);
    int meses = int.parse(_cantidadMeses.text);
    double tasa = 0;

    if (usarInteres) {
      if (!esNumeroPositivo(_tasaInteres.text)) return null;
      tasa = double.parse(_tasaInteres.text) / 100;
    }

    List<double> detalleMeses = [];
    double acumulado = 0;

    for (int i = 1; i <= meses; i++) {
      if (usarInteres) {
        // Aplicar interés mensual compuesto
        acumulado = (acumulado + ahorroMensual) * (1 + tasa);
      } else {
        // Sin interés
        acumulado += ahorroMensual;
      }
      detalleMeses.add(acumulado);
    }

    return {
      "total": acumulado,
      "detalle": detalleMeses,
    };
  }

  void mostrarResultado() {
    final resultado = calcularAhorro();
    if (resultado == null) {
      mostrarError("Por favor ingresa valores numéricos positivos en todos los campos requeridos.");
      return;
    }

    String detalleTexto = "";
    List<double> detalle = resultado["detalle"];
    for (int i = 0; i < detalle.length; i++) {
      detalleTexto += "Mes ${i + 1}: \$${detalle[i].toStringAsFixed(2)}\n";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ahorro acumulado"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total ahorrado: \$${resultado["total"].toStringAsFixed(2)}"),
              SizedBox(height: 10),
              Text("Detalle mes a mes:"),
              Text(detalleTexto),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          )
        ],
      ),
    );
  }

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Aceptar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SIMULADOR DE AHORRO MENSUAL")),
      drawer: MiDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Calcula tu ahorro acumulado con depósitos mensuales",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ahorroMensual,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ahorro mensual",
                  border: OutlineInputBorder(),
                  prefixText: "\$ ",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _cantidadMeses,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cantidad de meses",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: usarInteres,
                    onChanged: (value) {
                      setState(() {
                        usarInteres = value ?? false;
                        if (!usarInteres) _tasaInteres.clear();
                      });
                    },
                  ),
                  Text("Aplicar tasa de interés mensual"),
                ],
              ),
              if (usarInteres)
                TextField(
                  controller: _tasaInteres,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tasa de interés mensual (%)",
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: mostrarResultado,
                      icon: Icon(Icons.calculate),
                      label: Text("Calcular ahorro"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(31, 206, 230, 1),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: limpiarCampos,
                      icon: Icon(Icons.cleaning_services),
                      label: Text("Limpiar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 245, 114, 6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

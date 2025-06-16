import 'package:ejercicios_04/navigation/Drawer.dart';
import 'package:flutter/material.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EJERCICIO 2")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "CALCULADORA DE INTERÉS SIMPLE",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            inputCapital(),
            SizedBox(height: 10),
            inputTasa(),
            SizedBox(height: 10),
            inputTiempo(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                btnCalcularInteres(context),
                btnLimpiarCampos(),
              ],
            ),
          ],
        ),
      ),
      drawer: MiDrawer(),
    );
  }
}

// Controladores
TextEditingController _capital = TextEditingController();
TextEditingController _tasa = TextEditingController();
TextEditingController _tiempo = TextEditingController();

// Campos de entrada
Widget inputCapital() {
  return TextField(
    controller: _capital,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text("Capital Inicial (\$)"),
      border: OutlineInputBorder(),
    ),
  );
}

Widget inputTasa() {
  return TextField(
    controller: _tasa,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text("Tasa de Interés Anual (%)"),
      border: OutlineInputBorder(),
    ),
  );
}

Widget inputTiempo() {
  return TextField(
    controller: _tiempo,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text("Tiempo (años)"),
      border: OutlineInputBorder(),
    ),
  );
}

// Función de cálculo
Map<String, double>? calcularInteres() {
  try {
    double capital = double.parse(_capital.text);
    double tasa = double.parse(_tasa.text);
    double tiempo = double.parse(_tiempo.text);

    if (capital <= 0 || tasa <= 0 || tiempo <= 0) {
      return null;
    }

    double interes = capital * tasa * tiempo / 100;
    double montoFinal = capital + interes;

    return {
      "capital": capital,
      "interes": interes,
      "total": montoFinal,
    };
  } catch (e) {
    return null;
  }
}

// Botón para calcular
Widget btnCalcularInteres(context) {
  return FilledButton.icon(
    onPressed: () {
      var resultado = calcularInteres();
      if (resultado == null) {
        mostrarError(context);
      } else {
        mostrarResultado(context, resultado);
      }
    },
    icon: Icon(Icons.calculate),
    label: Text("Calcular"),
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.teal),
    ),
  );
}

// Botón para limpiar
Widget btnLimpiarCampos() {
  return FilledButton.icon(
    onPressed: () {
      _capital.clear();
      _tasa.clear();
      _tiempo.clear();
    },
    icon: Icon(Icons.cleaning_services),
    label: Text("Limpiar"),
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.orange),
    ),
  );
}

// Mensaje de resultado
void mostrarResultado(context, Map<String, double> resultado) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Resultado"),
      content: Text(
        "Capital inicial: \$${resultado["capital"]!.toStringAsFixed(2)}\n"
        "Interés generado: \$${resultado["interes"]!.toStringAsFixed(2)}\n"
        "Monto final: \$${resultado["total"]!.toStringAsFixed(2)}",
      ),
    ),
  );
}

// Mensaje de error
void mostrarError(context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Error de entrada"),
      content: Text("Por favor, ingrese solo valores numéricos positivos."),
    ),
  );
}

import 'package:ejercicios_04/navigation/Drawer.dart';
import 'package:flutter/material.dart';

class Pantalla1 extends StatelessWidget {
  const Pantalla1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CALCULADORA DE PROPINA")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
                child: Text("Calculadora de Propinas",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            SizedBox(height: 20),
            inputCuenta(),
            SizedBox(height: 10),
            inputPropinaPersonalizada(),
            SizedBox(height: 10),
            btnsPropina(context),
            SizedBox(height: 20),
            btnCalcular(context),
          ],
        ),
      ),
      drawer: MiDrawer(),
    );
  }
}

// Controladores
TextEditingController _cuenta = TextEditingController();
TextEditingController _customPropina = TextEditingController();

// Campo para el monto total de la cuenta
Widget inputCuenta() {
  return TextField(
    controller: _cuenta,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text("Monto total de la cuenta (\$)"),
      border: OutlineInputBorder(),
    ),
  );
}

// Campo para porcentaje personalizado de propina
Widget inputPropinaPersonalizada() {
  return TextField(
    controller: _customPropina,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      label: Text("Propina personalizada (%) - opcional"),
      border: OutlineInputBorder(),
    ),
  );
}

// Botones de propina
Widget btnsPropina(BuildContext context) {
  return Wrap(
    spacing: 10,
    children: [
      btnOpcion(context, 10),
      btnOpcion(context, 15),
      btnOpcion(context, 20),
    ],
  );
}

Widget btnOpcion(BuildContext context, int porcentaje) {
  return ElevatedButton(
    onPressed: () {
      calcularYMostrar(context, porcentaje.toDouble()); // <--- CORREGIDO AQUÍ
    },
    child: Text("$porcentaje%"),
    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
  );
}


// Botón para calcular con personalizada
Widget btnCalcular(BuildContext context) {
  return FilledButton.icon(
    onPressed: () {
      if (_customPropina.text.isEmpty) {
        mensajeError(context, "Ingresa un porcentaje o selecciona una opción.");
        return;
      }

      final porcentaje = double.tryParse(_customPropina.text);
      if (porcentaje == null || porcentaje < 0) {
        mensajeError(context, "La propina personalizada debe ser positiva.");
        return;
      }

      calcularYMostrar(context, porcentaje);
    },
    label: Text("Calcular con Propina Personalizada"),
    icon: Icon(Icons.calculate),
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(Color.fromRGBO(3, 65, 19, 1)),
    ),
  );
}

// Función de cálculo
void calcularYMostrar(context, double porcentaje) {
  double? cuenta = double.tryParse(_cuenta.text);

  if (cuenta == null || cuenta <= 0) {
    mensajeError(context, "El monto debe ser numérico y positivo.");
    return;
  }

  double propina = cuenta * (porcentaje / 100);
  double total = cuenta + propina;

  mensajeResultado(context, propina, total);
}

// Mostrar resultado
void mensajeResultado(context, double propina, double total) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Resultado"),
      content: Text(
          "Propina: \$${propina.toStringAsFixed(2)}\nTotal a pagar: \$${total.toStringAsFixed(2)}"),
    ),
  );
}

// Mostrar error
void mensajeError(context, String mensaje) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Error"),
      content: Text(mensaje),
    ),
  );
}

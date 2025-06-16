
import 'package:ejercicios_04/Screens/Pantalla1Screen.dart';
import 'package:ejercicios_04/Screens/Pantalla2Screen.dart';
import 'package:ejercicios_04/Screens/Pantalla3Screen.dart';
import 'package:flutter/material.dart';

void main (){
  runApp(Ejercicios02App());
}

class Ejercicios02App extends StatelessWidget {
  const Ejercicios02App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MOVILES III"),
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage( 
            fit: BoxFit.cover,
            image: AssetImage("assets/images/fondoo.jpg")),
            
        ),


        child: Center(
          child: Text("EJERCICIOS - 04",
          style:TextStyle(color: Color.fromRGBO(245, 246, 248, 1)) ,))),
          drawer: Drawer(
        child: ListView(children: [
          ListTile(
            title: Text("Ejercicio 1"),
            onTap: () => 
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Pantalla1())),
          ),
          ListTile(
            title: Text("Ejercicio 2"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Pantalla2())),
          ),
          ListTile(
            title: Text("Ejercicio 3"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Pantalla3())),
          )
        ],),
      ),
    );
  }
}


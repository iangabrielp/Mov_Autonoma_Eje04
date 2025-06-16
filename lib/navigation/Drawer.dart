
import 'package:ejercicios_04/Screens/Pantalla1Screen.dart';
import 'package:ejercicios_04/Screens/Pantalla2Screen.dart';
import 'package:ejercicios_04/Screens/Pantalla3Screen.dart';
import 'package:ejercicios_04/main.dart';
import 'package:flutter/material.dart';

class MiDrawer extends StatelessWidget {
  const MiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [

        
      
          ListTile(
            title: Text("Ejercicio 1",),
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
          ),

          ListTile(
            title: Row(
              children: [
                Icon(Icons.home_filled),
                Container(width: 10,),
                Text("home"),
              ],
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Ejercicios02App())),
          )

        ],),
      );
  }
}
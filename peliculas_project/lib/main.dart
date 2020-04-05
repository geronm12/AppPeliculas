 import 'package:flutter/material.dart';
import 'package:peliculas_project/src/pages/home_default.dart';
import 'package:peliculas_project/src/pages/peliculas_detalles.dart';

void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
     debugShowCheckedModeBanner: false,
     
     title: 'Peliculas',
     initialRoute: "/" ,
     routes: {
     '/'  : (BuildContext context) => Home(),
     'detalle'  : (BuildContext context) => PeliculaDetalle(),
       

     },
      
     
     
     
     );   }
 }
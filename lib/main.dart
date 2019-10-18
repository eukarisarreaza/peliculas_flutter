import 'package:flutter/material.dart';
import 'package:peliculas/src/page/home_page.dart';
import 'package:peliculas/src/page/pelicula_detalle.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: '/',
      routes: {
        '/'  :  (BuildContext context) => HomePage(),
        'detalle'  :  (BuildContext context) => PeliculaDetalle(),

      },
     
    );
  }
}
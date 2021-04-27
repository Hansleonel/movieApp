import 'package:flutter/material.dart';

import 'package:movieapp/src/pages/home_page.dart';
import 'package:movieapp/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO con esta propiedad manejamos el banner a lado derecho para mostrarlo o no dependiendo del caso
      // TODO en este caso no puesto que usamos un false
      debugShowCheckedModeBanner: false,
      // TODO con la propeidad "title" definimos el nombre de la aplicacion
      title: 'Movie App',
      // TODO con la propiedad "initialRoute" definimos la ruta inicial a la cual apuntara nuestra aplicacion
      initialRoute: '/',
      // TODO con la propiedad routes, podemos saber a que Page apunta dependiendo del nombre indicado con el String
      routes: {
        '/': (BuildContext context) => HomePage(),
        // TODO creando una ruta para nuestra pagina que es un StatlessWidget PeliculaDetalle()
        'detalle': (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}

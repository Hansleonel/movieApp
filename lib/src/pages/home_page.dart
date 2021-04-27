import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/movies_provider.dart';

import 'package:movieapp/src/widgets/card_swiper_widget.dart';
import 'package:movieapp/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  // TODO instanciando una variable del tipo fnl MoviesProvider() de nombre moviesProvider
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    // TODO haciendo el llamado a nuestro metodo getPopulares que no solo
    // TODO hace el llamado al API para obtener las peliculas populares de nuestra primera hoja
    // TODO tambien dentro de dicho metodo encontramos a nuestro sink
    // TODO que nos permite controlar la entrada de datos
    // moviesProvider.getPopulars();

    // TODO agregando esta condicion para que no se repita el llamado cada vez que renderize el metodo
    // TODO build(), y lo haga solo cuando getPopulareSize sea igual a 0 es decir
    // TODO solo cuando se haga el llamado a getPopulars() cuando nosotros lo decidamos
    // TODO y no cuando solo se este renderizando el build() de nuestro Widget HomePage()
    if (moviesProvider.getPopularesSize() == 0) {
      moviesProvider.getPopulars();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        // TODO como vemos la propiedad "actions" de neustro Widget Appbar
        // TODO recibe un array de Widgets
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      // TODO como vemos la proiedad "body" de nuestro Widget Scaffold()
      // TODO recive un Widget en este caso el Widget SafeArea() dicho
      // TODO Widget nos permite mostrar de manera correcta a todos los demas Widgtes
      // TODO sin que el notch de algunos telefonos android y el iPhone interrumpa la visualizacion
      // body: SafeArea(child: Text('Texto inicial de la aplicación')),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperCards(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getEnCines(),
      // TODO no usaremos la propiedad "initalData" de neustro Widget FutureBuilder()
      // TODO puesto que queremos usar un loading
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(moviesList: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
    // TODO llamando al metodo "".genEnCines()"" que como sabes es un Future
    // TODO que nos devolver un list List<Movie> que son una listado de elementos del tipo Movie
    // moviesProvider.getEnCines();

    // TODO usando un Widget personalizado, dicho Widget tiene un propiedad
    // @required, es por eso que enviamos la List movieList
    // return CardSwiper(moviesList: [1, 2, 3, 4]);

    /*Container(
      padding: EdgeInsets.only(top: 10.0),
      // TODO estas propiedades "width" y "height" son necesarias para que el Widget Swiper
      // TODO funcione correctamente aunque no lo mencione la documentcion del Widget Swiper
      width: double.infinity,
      height: 300.0,
      // TODO como vemos el Widget Swiper tiene que ser contenido por el Widget Container y su propiedad
      // TODO "child" puesto que necesitaba de las propiedades "width" y "heigth" de nuestro Widget Container
      child: Swiper(
        itemWidth: 200.0,
        // TODO la propiedad "layout" nos permite saber que tipo de visualizacion de Swiper queremos
        layout: SwiperLayout.STACK,
        // TODO la propiedad "itemBuilder" nos permite contruir nuestro Widget Swiper
        // TODO en este caso usaremos una Widget Image.network para poder visulizar una imagen
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "https://www.nawpic.com/media/2020/aesthetic-nawpic-9.jpg",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
      ),
    );*/
  }

  Widget _footer(BuildContext context) {
    return Container(
      // TODO para que ocupe todo el espacio restante luego de ubicarse
      // TODO debajo de el Widget _swiperCards()
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 5.0),
          // TODO reemplazando el Widget FutureBuilder() por el Widget StreamBuilder()
          // TODO para poder volver a renderizar el Widget y ver el listado de peliculas
          // TODO ampliarze
          // FutureBuilder(
          StreamBuilder(
              // future: moviesProvider.getPopulars(),
              // TODO usando la instanciacion moviesProvider para acceder a nuestro Stream
              // TODO popularesStream es decir ya estamos escuchando la emision de los datos
              // TODO pero ahora debemos de manejar la entrada de los datos que emitiremos
              // TODO con la ayuda del sink, dicho sink sera llamado desde
              // TODO el build de nuestro Widget HomePage()
              stream: moviesProvider.popularesStream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                // TODO el signo de interrgcn representa la condicional
                // TODO de solo recorrer el arreglo elemento por elemento
                // TODO si el elemento no es NULL
                // snapshot.data?.forEach((element) => print(element.title))
                if (snapshot.hasData) {
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    // TODO como vemos ahora tambien necesitamos enviar una funcion
                    // TODO a nuestro Widget MovieHorizontal puesto que es un parametro
                    // TODO required es decir obligatorio, recordemos que solo debemos de enviar
                    // TODO la definicion de la misma es decir sin usar los signos "()"
                    siguientePagina: moviesProvider.getPopulars,
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}

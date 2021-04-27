import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO recibiendo argumentos desde otra pagina mediante
    // TODO las rutas, en este caso desde el StatelesWidget MovieHorizontal()
    final Movie pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      // TODO como vemos usaremos el Widget CustomScrollView
      // TODO dicho Widget nos permite hacer desplazamientos con la UI de manera
      // TODO mas interactiva
      body: CustomScrollView(
        // TODO la propiedad slivers recibe un conjunto Array de Widgets
        slivers: <Widget>[
          _crearAppBar(pelicula),
          // TODO dentro del propiedad slivers de nuestro Widget CustomScrollView
          // TODO debemos de usar el Widget SliverList para la visulizacion correcta
          // TODO ademas debemos de usar el la propiedad delegate que recibira
          // TODO el SliverChildListDelegate que como vemos
          // TODO tiene un argumento posicional que recibe un listado de Widgets
          // TODO el SliverList tiene un comprtamiento parecido al ListView
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
                // TODO creamos un Widget para mostrar nuestro Poster
                // TODO luego del Widget SizedBox
                _posterTitulo(context, pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
          ])),
        ],
      ),
    );
  }

  Widget _crearAppBar(Movie pelicula) {
    // TODO como vemos usaremos el WidgetSliveAppBar que dara el efecto de desplazamiento
    // TODO al appBar ademas de poder personalizar dicho tipo de appBar insertando Widgets
    // TODO para mejorar la UI
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      // TODO la propiedad expandedHeight, es el tamaño que tomara nuestro Widget
      // TODO como maximo, ya expandido
      expandedHeight: 200.0,
      floating: false,
      // TODO hace que el Widget siga siendo visible aun cuando se haga Scroll
      pinned: true,
      // TODO la propiedad flexibleSpace de nuestro Widget SliverAppBar()
      // TODO recibe un Widget, dicho Widget se acomodara dentro de nuestro Widget SliverAppBar()
      // TODO siempre y cuando reciba el Widget FlexibleSpaveBar()
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getbackdropImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Movie pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: <Widget>[
          // TODO usamos el Widget ClipRRect para darle los
          // TODO el redondeado al Widget que recibimos
          // TODO en la propiedad child
          // TODO que como sabemos dicho Widget recibido
          // TODO es el Widget FadeInImage()
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                height: 150.0,
                placeholder: AssetImage('/assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg())),
          ),
          // TODO dando un espacio en la fila
          // TODO entre el Widget ClipRRect() y el Widget Flexible()
          SizedBox(width: 16.0),
          // TODO el Widget Flexible se acomodara en todo el espacio
          // TODO restante de la fila
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO Widget dentro de la columna
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                // TODO Widget dentro de la columna
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                // TODO Widget dentro de la columna
                Row(
                  children: <Widget>[
                    // TODO Widget dentro de la fila
                    Icon(
                      Icons.star_rate,
                      color: Colors.yellow,
                    ),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Movie pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Text(pelicula.getDescription(), textAlign: TextAlign.justify),
    );
  }
}

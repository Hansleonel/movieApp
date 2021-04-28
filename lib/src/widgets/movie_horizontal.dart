import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> peliculas;
  // TODO para poder llamar a una funcion de nuestro Widget Padre es decir de
  // TODO el Widget HomePage() crearemos un nuevo parametro obligatorio cuando
  // TODO se necesite usar el Widget MovieHorizontal()
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  // TODO llamando el metodo de un Widget Padre en este caso el Widget HomePage()
  // TODO desde del Widget hijo MovieHorizontal()

  @override
  Widget build(BuildContext context) {
    // TODO el valor del tamaño de la pantalla
    final _screenSize = MediaQuery.of(context).size;

    // TODO detectando cuando se llega al fnl del scroll del movie horizontal
    // TODO ademas como vemos usaremos el listener dentro del metodo build() dado que
    // TODO un StatelessWidget no tiene un metodo initState() desde el cual llamar
    // TODO el .addListener() tal y como lo haciamos desde el InfiniteScroll
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        print('Cargar siguientes movies');
        // TODO llamando un metodo del Widget Padre es decir llamando un metodo del Widget HomePage()
        // TODO el metodo es el que creamos como parametro obligatorio para usar el Widget MovieHorizontal()
        siguientePagina();
      }
    });

    return Container(
      child: Container(
          height: _screenSize.height * 0.2,
          child:
              /*PageView(
            // TODO usando propiedades de nuestro Widget PageView
            // TODO para mejorar la vista a mostrarse
            pageSnapping: false,
            controller: _pageController,

            // TODO el children recibe una lista de Widgets
            // TODO es por eso que el metodo _tajertas debe de devolver
            // TODO una lista de Widgets
            children: _tarjetas(context)),*/

              // TODO Reemplazando el Widget PageView() por un Widget PageView.Builder()
              // TODO la diferencia entre estos dos Widgets es que el Widget PageView.Builder()
              // TODO nos permite renderizar las elementos solo cuando se necesitan
              // TODO a diferencia del Widget PageView() que renderiza todos los elementos a la vez
              // TODO y en ciertos dispostivs esto podria ocacionar alguns problms
              PageView.builder(
                  pageSnapping: false,
                  controller: _pageController,
                  itemCount: peliculas.length,
                  itemBuilder: (context, index) {
                    return _tarjeta(context, peliculas[index]);
                  })),
    );
  }

  Widget _tarjeta(BuildContext context, Movie pelicula) {
    // TODO creamos una variable u la igualamos a todo nuestro Widget Container()
    // TODO que es usado para formar tarjeta por tarjeta
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/loading.gif'),
              // TODO usala variable "pelicula" que es tomada de el recorrido
              // TODO del listado List<Movie> peliculas
              // TODO al ser tomada de dicho listado y ser del tipo "Movie"
              // TODO podemos usar el metodo "getPosterImg()" para poder conseguir
              // TODO las imagienes que mostrara el Widget FadeInImage()
              // TODO con la ayuda del NetworkImage()
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // TODO al ser el texto que usar nuestro Widget Text()
          // TODO un argumento posicional podemos usar la variable pelicula
          // TODO que como sabemos recorre el listado List<Movie> peliculas
          Text(
            pelicula.title,
            // TODO la propiedad overflow nos permite limitar el espacio para mostrar
            // TODO el text en la propiedad posicional
            // TODO y mostrar tres punts
            overflow: TextOverflow.ellipsis,
            // TODO al usar el context debemos de recibir dicho context
            // TODO en el metodo _tarjetas desde el Widget build() del Widget
            // TODO general MovieHorizontal()
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    // TODO Usando un Widget que detecte cuando realicemos un gesto con el,
    // TODO como vemos el Widget Container() no posee dicha propiedad
    // TODO asique usaremos el Widget GestureDectector()
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        // TODO usamos la variable que recibio nuestro Widget _tarjeta(BuildContext context, Movie pelicula)
        // TODO para manejar sus propiedades en este caso la propiedad title
        print("el nombre de la pelicula es ${pelicula.id}");
        // TODO usaremos el gesto onTap() que es una propiedad de nuestro Widget GestureDetector()
        // TODO para poder navegar de una pantalla a otra y enviar argumentos usando el PushNamed
        // TODO como sabemos el primer argumento es el BuildeContext context, el nombre de la ruta
        // TODO que en este caso seria "detalle" y luego pasamos los argumentos que queremos enviar
        // TODO que deben de ser enviados en forma de objeto, en este caso enviamos todo el objeto "pelicula"
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/loading.gif'),
                // TODO usala variable "pelicula" que es tomada de el recorrido
                // TODO del listado List<Movie> peliculas
                // TODO al ser tomada de dicho listado y ser del tipo "Movie"
                // TODO podemos usar el metodo "getPosterImg()" para poder conseguir
                // TODO las imagienes que mostrara el Widget FadeInImage()
                // TODO con la ayuda del NetworkImage()
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            // TODO al ser el texto que usar nuestro Widget Text()
            // TODO un argumento posicional podemos usar la variable pelicula
            // TODO que como sabemos recorre el listado List<Movie> peliculas
            Text(
              pelicula.title,
              // TODO la propiedad overflow nos permite limitar el espacio para mostrar
              // TODO el text en la propiedad posicional
              // TODO y mostrar tres punts
              overflow: TextOverflow.ellipsis,
              // TODO al usar el context debemos de recibir dicho context
              // TODO en el metodo _tarjetas desde el Widget build() del Widget
              // TODO general MovieHorizontal()
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}

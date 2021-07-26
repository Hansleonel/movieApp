import 'package:flutter/material.dart';
import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  // TODO creando una variable para manejar el item seleccionado de nuestra
  // TODO lista de sugerencias
  String selectionItem = '';

  // TODO instanciando una variable de tipo MoviesPrivider()
  final moviesProvider = new MoviesProvider();

  // TODO Arrays para utilizar el buildSugestions() de manera local

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam',
    'IronMan',
    'Capitan',
    'Superman',
    'Iron man 1',
    'Iron man 2'
  ];
  final peliculasRecientes = ['Spiderman', 'Capitan'];

  // TODO el metodo buildActions nos permite realizar acciones
  // TODO desde la parte derecha de nuestro showSearch()
  // TODO una de los ejemplos mas concocidos es la accion de limpiar
  // TODO todo el texto de nuestra posible busqueda
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO como vemos el buildActions devuelve una lista de Widgets
    // TODO en este caso solo devolverems un Widget IconButton()
    return <Widget>[
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            print('click');
            // TODO como en esta ocacion queremos que nuestra accion de nuestro
            // TODO buildActions() sea la de limpiar nuestra posible busqueda
            // TODO solo tenemos que usar nuestra variable predefinida query
            // TODO e igualarla a un campo vcio ''
            query = '';
          })
    ];
  }

  // TODO el metodo buildLeading nos permite visualizar un iconoo al lado
  // TODO izquierdo de nuestro showSearch() generalmente iconos
  @override
  Widget buildLeading(BuildContext context) {
    // TODO como vemos el buildLeading nos pide devolvr solo un Widget
    // TODO en este caso devolvrms el Widget IconButton()
    // TODO ademas la propeidad icon de nuestro Widget IconButton()
    // TODO recibira un Widget AnimatedIcon() lo cual nos permitira usar
    // TODO dicho Widget que nos permite ver una animacion cuando interactuamos
    // TODO con sus acciones
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          print("Leading Icon Press");
          // TODO podemos utilizar un metodo predefinido de nuestro
          // TODO SearchDelegate() con el nombre de close()
          // TODO que recive dos argumentos el context y el result
          // TODO en este caso si tenemos el context y lo enviamos
          // TODO y podemos dejar tal y como esta el result
          close(context, null);
        });
  }

  // TODO son los resultados a mostrar dentro de nuestro showSearch()
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.yellow,
        child: Text(selectionItem),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO usamos el query que es una variable predetermianda de nuestro
    // TODO SearchDelegate()
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: moviesProvider.searchMovie(query),
        // TODO como sabemos el valor de nuestro argumento snapshot
        // TODO viene luego de resolverse el future, que en este caso es
        // TODO el Future moviesProvider.searchMovie(query)
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            // TODO creando una variable peliculasList en caso el snapshot
            // TODO si tenga valores encontrados
            final peliculasList = snapshot.data;

            return ListView(
                children: peliculasList.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  // TODO podemos cerrar el searchDelegate() antes de navegar
                  // TODO hacia la pagina 'detalle'
                  close(context, null);
                  // TODO recordemos que necesitamos asignarle un valor
                  // TODO a la propiedad uniqueId de nuestra instancia pelicula
                  // TODO para prevenir problems con el HeroAnimation()
                  pelicula.uniqueId = '';
                  // TODO Navegando a la pagina 'detalle' y enviando
                  // TODO dentro de la propiedad arguments, toda la pelicula
                  // TODO ademas usamos el BuildContext context
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList());
          } else {
            // TODO en caso el snapshot no tenga datos
            // TODO devolver un Widget CircularProgressIndicator()
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // TODO son las sugerencias que se muestran dentro de nuestro showSearch()
  /* @override
  Widget buildSuggestions(BuildContext context) {
    // TODO para realizar una busqueda dentro de una lista en este caso dentro de Peliculas
    // TODO debemos de crear una Lista, en este caso listaSugeria, e igualarla
    // TODO a la busqueda en caso la lista este vacia "(query.isEmpty)"
    // TODO devolvemos peliculasRecientes
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        // TODO en caso no se cumpla la condicion de (query.isEmpty)
        // TODO devolvemos una lista peliculas que cumplan con una condicion adicional
        // TODO Where((element)=> elemento.toLoweCase().startsWith(query.toLowerCase()))
        // TODO en dicha condicion vemos que devolvemos todos los elementos que
        // TODO empiecen con el query recibido
        : peliculas
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    // TODO en este caso usaremos el Widget ListView.Builder()
    // TODO dicho Widget nos permite devlvr un listado de elementos
    // TODO de manera mas optima que el Widget ListView()
    return ListView.builder(
        itemCount: listaSugerida.length,
        // TODO el argumento itemBuilder es obligatorio
        // TODO ademas recibe una funcion con los argumentos BuildContext context
        // TODO y un index del tipo Int para realizar un recorrido entre sus elementos
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[index]),
            onTap: () {
              // TODO igualamos la variable selectionItem
              // TODO al item seleccionado en nuestro listado de nuestro
              // TODO Widget ListTile(), dicha variable se utilizara el
              // TODO metodo buildResult()
              selectionItem = listaSugerida[index];
              // TODO para activar el buildResult() debemos de usar el
              // TODO metodo predefinido para esta accion llamado
              // TODO showResults(context) que como vemos
              // TODO recibe un BuildContext
              showResults(context);
            },
          );
        });
  } */
}

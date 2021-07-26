// TODO para realizar esta importacion debemos de usar la dependecia
// TODO http de dart dentro de nuestro pubsec.yaml
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:movieapp/src/models/movie_model.dart';
import 'package:movieapp/src/models/actors_model.dart';

class MoviesProvider {
  String _apikey = '05d4eb27ef5bd3bb8d836f2d24dcbad6';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // TODO variables para manjera la paginacion devuelta desde la api
  int _popularesPage = 0;
  List<Movie> _populares = new List();

  // TODO variable para controlar el numero de peticiones cuando se llega al fnl del
  // TODO scroll sea solo una peticion por cada fnl de scroll y no multiples
  // TODO como se viene realizando hasta el momento
  bool _cargando = false;

  // TODO CREACION DEL STREAM
  // TODO comos sabemos los streamController se visualizan como tuberias
  // TODO ademas podemos indicarle el tipo de informacion que fluira por esa
  // TODO tuberia en este caso el tipo sera una lista List<Movie>, adicionalmente
  // TODO como vemos podemos decirle con el "".broadcast()" que dicho stream
  // TODO sera escuchado desde muchos lugares
  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  // TODO AGREGANDO LOS GETTERS PARA CONTROLAR LA ENTRADA Y LA SLIDA DE LOS STREAMS

  // TODO FUNCION GET PARA CONTROLAR LA ENTRADA DE DATOS AL STREAMCONTROLLER
  // TODO COMO VEMOS LE DAMOS COMO REGLA QUE SOLO SEA DEL TIPO LISTA List<Movie>
  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  // TODO STREAM GET PARA CONTROLLAR LA EMISION DE DATOS DEL STREAMCONTROLLER
  // TODO COMO VEMOS LE DAMOS COMO REGLA QUE SOLO SEA DEL TIPO <List<Movie>>
  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  //TODO METODO PARA CERRA EL STREAM
  void disposeStream() {
    _popularesStreamController?.close();
  }

  // TODO metodo para optimizar codigo repetido
  // TODO en este caso parte del codigo del metodo getEnCines()
  // TODO y el metodo getPopulars()
  Future<List<Movie>> _procesaRespuesta(Uri url) async {
    final respuestaEsperada = await http.get(url);
    final decodedDataFromRespuestaEsperada =
        json.decode(respuestaEsperada.body);

    final movies =
        new Movies.fromJsonList(decodedDataFromRespuestaEsperada['results']);

    print(movies.itemsMovie[1].title);

    return movies.itemsMovie;
  }

  // TODO el future es una promesa de que devolvera un <T>
  // TODO en este caso el <T> es una lista List<Movie>
  Future<List<Movie>> getEnCines() async {
    // TODO variable del tipo fnl URI que nos permite armar una URL
    // TODO para realizar peticiones http
    // TODO recordar que para que la aplicacion pueda realizar peticiones
    // TODO http debemos de modificr el archiv pubsec.yaml
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apikey, 'language': _language});

    // TODO al estar usando el async y el await estamos esperando hasta que la
    // TODO peticion "http.get(url)" obtenga una respuesta
    // final respuestaEsperada = await http.get(url);
    // final decodedDataFromRespuestaEsperada =
    //    json.decode(respuestaEsperada.body);

    // TODO INSTANCIAMOS una variable del tipo fnl Movies, que usara el metodo ".fromJsonList()"
    // TODO que almacenara solo el listado de la respuesta de nuestro http que pertenecezcan
    // TODO al parametro 'results' en este caso al array de peliculas,
    // TODO ademas todo el resultado de nuestro JSON y el parametro 'results' es enviado
    // TODO al CONSTRUCTOR Movies.fromJSONList() que recorre el JSON y crea un listado de peliculas
    // TODO y las agrega a la variable List<Movie> itemsMovie
    // final movies =
    //    new Movies.fromJsonList(decodedDataFromRespuestaEsperada['results']);

    // TODO ACCEDIENDO A LA VARIABLE "itemsMovie" GRACIAS A LA INSTANCIA "movies",
    // TODO ademas al ser "itemsMovie" un listado de tipo movie List<Movie> itemsMovie,
    // TODO podemos acceder al primere elemento con el los corchets "[]" y el numero de orden del elemento
    // TODO en este caso el 0, ademas una vez que sabemos el nuemro de orden del emento, podemos acceder
    // TODO a las propiedades de dicho elemento que como sabemos es del tipo Pelicula
    // TODO y tiene elemenso como id, title, posterPath, entre otras propiedades
    // TODO en este caso solo accederemos al title
    // print(movies.itemsMovie[1].title);

    // TODO como vemos estamos retornando un List<Movie> como mencionamos a la hora de crear este Future
    // TODO con el nombre de getEnCines(), es decir estamos retornando muchos elementos del tipo Movie
    //return movies.itemsMovie;

    return await _procesaRespuesta(url);
  }

  Future<List<Movie>> getPopulars() async {
    // TODO como sabemos la variable _cargando de tipo bool
    // TODO inicializa con false es decir continua su recorrido
    if (_cargando) return [];

    // TODO si la variable _cargando continua su recorrido entonces le asignamos el valor de
    // TODO true , hacemos esto para que cuando quiera hacer una peticion repetida,
    // TODO con la ayuda de la condicional if(_cargando) active el return[]
    _cargando = true;

    // TODO variable para manejar la paginacion devuelta por la api
    _popularesPage++;

    // TODO impresion para ver cuantas veces se hace llamado a este metodo con nuestro
    // TODO llamado con el uso de Streams
    print('Cargando Siguientes peliculas por vez numero $_popularesPage');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'lenguage': _language,
      'page': _popularesPage.toString()
    });

    // TODO optimizando codigo y utilizando codigo repetido de metodos
    // TODO getPopulars y getEnCnes con el metodo _procesaRepuesta(url)

    /* final respuestaEsperada = await http.get(url);
    final decodedDataFromRespuestaEsperada =
        json.decode(respuestaEsperada.body);

    final movies =
        new Movies.fromJsonList(decodedDataFromRespuestaEsperada['results']);

    print(movies.itemsMovie[1].title);

    return movies.itemsMovie;*/

    final resp = await _procesaRespuesta(url);

    // TODO MODIFICANDO ESTAS LINEAS PARA USAR NUESTRO STREAMCONTROLLER Y NUESTRO
    // TODO SINK QUE MANEJA LA ENTRADA DE DATOS A DICHO STREAMCONTROLER
    // TODO PRIMERO USAMOS LA VARIABLE CREADA AL INICIO _populares
    // TODO DICHA VARIABLE SERA EL CONTENEDOR DE NEUSTRA VARIABLE resp
    // TODO QUE COMO VEMOS ES LA REPSUESTA QUE CON LA AYUDA DE UN AWAIT ESPERA A
    // TODO NUESTRA API PARA OBTENER LA LISTA DE PELICULAS POPULARES
    // TODO USAMOS ".addAll()" PUESTO QUE NECETAMOS LA LISTA ENTERA
    // TODO Y SI USAMOS SOLO ".add" NOS DARIA UN ERROR PUESTO QUE SOLO QUERRA AGREGAR
    // TODO UNA PELICULA
    _populares.addAll(resp);

    // TODO USANDO EL GET popularesSink()
    popularesSink(_populares);

    // TODO en caso se hayamos continuado asignamos el valor de false a la variable _cargando
    // TODO para que pueda ingresar solo cuando nosotros lleguemos al fnl del scroll
    // TODO y no multiples veces
    _cargando = false;
    // return await _procesaRespuesta(url);
    return resp;
  }

  int getPopularesSize() => _populares.length;

  // TODO como vemos tambien crearemos un future para poder esperar
  // TODO la respuesta de nuestra API y poder hacerle un decode
  // TODO para poder tratarla como un JSON
  Future<List<Actor>> getCast(String peliId) async {
    final urlActor = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    // TODO esperando respuesta de un API
    final resp = await http.get(urlActor);
    // TODO haciendo el .decode() del body de la respuesta previamente esperada
    // TODO ademas usando una variable para almacenar todo el JSON
    final decodedData = json.decode(resp.body);

    // TODO una vez tengamos el JSON podemos acceder a sus propiedades
    // TODO en este caso accedemos a su propiedad ['cast']
    final cast = new Cast.fromJsonList(decodedData['cast']);

    // TODO ademas accedemos a la variable "actoresList" de nuestra clase
    // TODO Cast que como vemos ya tiene un valor almacenado luego de que usamos
    // TODO el metodo ,fromJsonList(), y es del tipo List<Actor>, tal y como
    // TODO necesitaba devolvr el Future<List<Actor>> getCast()
    return cast.actoresList;
  }

  // TODO Future para esperar respuesta de nuestra API
  // TODO en este caso para acceder a los resultados de un busqueda de una pelicula
  Future<List<Movie>> searchMovie(String query) async {
    final urlMovie = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _procesaRespuesta(urlMovie);
  }
}

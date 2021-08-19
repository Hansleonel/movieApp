import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  // TODO lista de peliculas del tipo List<Movie>
  final List<Movie> moviesList;

  // TODO se inicializa la lista movieList
  // TODO en el constructor del Widget CardSWiper
  CardSwiper({@required this.moviesList});

  @override
  Widget build(BuildContext context) {
    // TODO modificando las dimensiones de la tarjeta dependiendo del dispositivo
    // TODO el equivalente al responsiv
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      // TODO como vemos el Widget Swiper tiene que ser contenido por el Widget Container y su propiedad
      // TODO "child" puesto que necesitaba de las propiedades "width" y "heigth" de nuestro Widget Container
      child: Column(
        children: [
          Text('Playing Now'),
          SizedBox(
            height: 8.0,
          ),
          Swiper(
              // TODO con las propeidades itemWidth e itemHight
              // TODO nos permite establecer el tamaño de los elementos del Swiper
              // TODO en este caso usaremos la variable _screenSize
              // TODO que como sabemos nos envia el tamaño de la pantalla
              // TODO gracias al MediaQuery
              itemWidth: _screenSize.width * 0.7,
              itemHeight: _screenSize.height * 0.5,
              // TODO la propiedad "layout" nos permite saber que tipo de visualizacion de Swiper queremos
              layout: SwiperLayout.STACK,
              // TODO la propiedad "itemBuilder" nos permite contruir nuestro Widget Swiper
              // TODO en este caso usaremos una Widget Image.network para poder visulizar una imagen
              itemBuilder: (BuildContext context, int index) {
                // TODO asignandole un valor unico a nuestra propiedad "uniqueId"
                moviesList[index].uniqueId = '${moviesList[index].id}-tarjeta';

                return Hero(
                  // TODO enviando una valor unico al Widget Hero() de nuestra pagina
                  // TODO pelicula_detalle
                  tag: moviesList[index].uniqueId,

                  // TODO para poder perzonalizar la imagen que se mostrara
                  // TODO con el Widget Swiper()
                  // TODO envolveremos la respuesta, que en este caso era un
                  // TODO Widget Image.network, dentro de un Widget ClipRRect()
                  // TODO ademas la propiedad "fit" de nuestro Widget Image.network()
                  // TODO ahora recibira un BoxFit.cover
                  child: ClipRRect(
                      /*child: Image.network(
                      "https://www.nawpic.com/media/2020/aesthetic-nawpic-9.jpg",
                      fit: BoxFit.cover,
                    ),*/
                      borderRadius: BorderRadius.circular(20.0),
                      child: GestureDetector(
                        child: FadeInImage(
                          // TODO para usar un recurso estatic debemos de modifcr neustro pubspec.yaml
                          // TODO y habilitar la carpeta donde esta nuestro recurso
                          placeholder: AssetImage('assets/img/no-image.jpg'),
                          // TODO usaremos el valor de index de nuestra propiedad "itemBuilder",
                          // TODO que comos sabemos pertenece a nuetro Widget Swiper(),
                          // TODO dicha propiedad "itemBuilder" nos permite hacer un recorrido
                          // TODO por cada Swipe que crea con la ayuda de la propiedad
                          // TODO "itemCount" que como sabemos pertenece al Widget padre Swiper()
                          image: NetworkImage(moviesList[index].getPosterImg()),
                          // TODO la propiedad fit nos permite establece el modo en el que se verá
                          // TODO nuestro Widgte FadeInImage()
                          // TODO en este caso la imagen se mostrara de acuerdo a las medidas dadas al Widget
                          // TODO padre es decir el Widget ClipRRect() que tiene un border Radius de 20.0
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'detalle',
                              arguments: moviesList[index]);
                        },
                      )),
                );
              },
              // TODO como vemos la propiedad "itemCount" de nuestro Widget
              // Swiper(), recibira como valor el tamaño de nuestra List movieList
              itemCount: moviesList.length),
        ],
      ),
    );
  }
}

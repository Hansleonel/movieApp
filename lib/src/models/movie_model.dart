// TODO contenedor de todas las peliculas
class Movies {
  // TODO ATRIBUTO DE NUESTRA CLASE MOVIE QUE ES UNA
  // TODO Lista del tipo Movie List<Movie>
  List<Movie> itemsMovie = new List();

  // TODO este es el constructor de la clase Movies con el nombre de Movies()
  Movies();

  // TODO Method .fromJsonList(), que recibira un List del tipo <dynamic>
  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    // TODO recorriendo el jsonList con la variable item
    for (var item in jsonList) {
      // TODO cada recorrido usara el motodo .fromJsonMap(item)
      // TODO para luego igual dicho valor a la variable final movie
      final movie = new Movie.fromJsonMap(item);
      // TODO agregando el valor resultante de movie a nuestra
      // TODO lista List<Movie> itemsMovie
      itemsMovie.add(movie);
    }
  }
}

class Movie {
  // TODO creamos esta propiedad para solucionar el problema
  // TODO del Widget Hero, que como sabemos necesita enviar y recibir
  // TODO un valor unico de una pagina a otra, incluso si los dos Widgets
  // TODO Hero() se encuentra en una misma pagina y quieren interacturar con un
  // TODO mismo Widget Hero() de la otra pagina
  String uniqueId;

  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movie.fromJsonMap(Map<String, dynamic> jsonMap) {
    voteCount = jsonMap['vote_count'];
    id = jsonMap['id'];
    video = jsonMap['video'];
    voteAverage = jsonMap['vote_average'] / 1;
    title = jsonMap['title'];
    popularity = jsonMap['popularity'] / 1;
    posterPath = jsonMap['poster_path'];
    originalLanguage = jsonMap['original_language'];
    originalTitle = jsonMap['original_title'];
    genreIds = jsonMap['genre_ids'].cast<int>();
    backdropPath = jsonMap['backdrop_path'];
    adult = jsonMap['adult'];
    overview = jsonMap['overview'];
    releaseDate = jsonMap['release_date'];
  }

  // TODO metodo para devlvr la SOLO la imagen de la pelicula
  getPosterImg() {
    // TODO en caso no exista un poster y nos retorne un poster null
    if (posterPath == null) {
      return 'https://kbimages.dreamhosters.com/images/Site_Not_Found_Dreambot.fw.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }

  getbackdropImg() {
    if (backdropPath == null) {
      return 'https://kbimages.dreamhosters.com/images/Site_Not_Found_Dreambot.fw.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
  }

  getDescription() {
    if (overview == null) {
      return 'NO DISPONIBLE';
    } else {
      return overview;
    }
  }
}

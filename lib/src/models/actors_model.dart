class Cast {
  List<Actor> actoresList = new List();

  // TODO el metodo para tener la lista de los actores
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    // TODO recorriendo el jsonList item por item
    jsonList.forEach((element) {
      // TODO usando el metodo de nuestra clase Actor .fromJsonMap(element)
      // TODO para enviar dicho item de recorrido, en esta ocacion con el nombre de "element"
      final actor = Actor.fromJsonMap(element);
      // TODO una vez procesado con el metodo .fromJsonMap(element)
      // TODO agregamos dicho valora una lista, en este caso actoresList que es del tipo Actor
      actoresList.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.gender,
    this.id,
    this.name,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  Actor.fromJsonMap(Map<String, dynamic> jsonMap) {
    gender = jsonMap['gender'];
    id = jsonMap['id'];
    name = jsonMap['name'];
    profilePath = jsonMap['profile_path'];
    castId = jsonMap['cast_id'];
    order = jsonMap['order'];
    character = jsonMap['character'];
    creditId = jsonMap['credit_id'];
  }

  getPhotoActor() {
    if (profilePath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }
}

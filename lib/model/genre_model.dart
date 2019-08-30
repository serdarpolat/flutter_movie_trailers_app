class GenreModel {
  List<Genre> genres = [];
  
  GenreModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Genre> temp = [];

      for (var i = 0; i < parsedJson['genres'].length; i++) {
        Genre genre = Genre(parsedJson['genres'][i]);
        temp.add(genre);
      }
      temp = temp.toSet().toList();
      genres = temp;
  }

  List<Genre> get getGenres => genres;

  String getGenre(List<int> ids) {
    ids = ids.toSet().toList();
    String mygenre = "";

    for (var i = 0; i < ids.length; i++) {
      mygenre += genres.where((user) => user.id == ids[i]).first.name + ", ";
    }

    mygenre = mygenre.substring(0, mygenre.length - 2);

    return mygenre;
  }
}

class Genre {
  int id;
  String name;

  Genre(genres) {
    id = genres['id'];
    name = genres['name'];
  }

  int get getId => id;
  String get getName => name;
}
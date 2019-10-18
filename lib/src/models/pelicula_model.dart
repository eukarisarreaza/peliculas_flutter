

class Peliculas{
  List<Pelicula> items= List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    
    for (var item in jsonList) {
      final pelicula= Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }

}


class Pelicula {

  String uniqueId;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });


  Pelicula.fromJsonMap(Map<String, dynamic> json){
    
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;  // si llega entero para convertir a double
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];

  }

  String getPosterImg(){
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/ceeda4b0-2ef0-0137-a2f3-0242ac11000a/icons/icon-no-image.svg';
    }else
      return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

    String getBackgroundImg(){
    if (posterPath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/ceeda4b0-2ef0-0137-a2f3-0242ac11000a/icons/icon-no-image.svg';
    }else
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}

enum OriginalLanguage { EN, RU, JA, TL }

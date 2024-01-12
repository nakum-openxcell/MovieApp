class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageUrl = 'https://image.tmdb.org/t/p/w100/';

  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  // auth endpoints
  static const String discover = '$baseUrl/discover/movie';
}

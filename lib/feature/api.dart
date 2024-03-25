class Api {
  static const basePath = "https://api.github.com/";

  static String searchRepGET({required String text}) => '/search/repositories?q=$text';
}

class ApiUtils {

  static const baseUrl = "https://rickandmortyapi.com/api/";
  static String getAllCharacter(int page) {
    return "$baseUrl/character?page=${page}";
  }



}
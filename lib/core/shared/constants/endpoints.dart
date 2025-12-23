class AppEndpoints {

  static const String baseUrl = 'https://dummyjson.com';
  static const String authBase = '$baseUrl/auth';


  static const String login = '$authBase/login';
  static const String refreshToken = '$authBase/refresh';
  static const String getAuthUser = '$authBase/me';


  static const String getUsers = '$baseUrl/users';
  static String getUserById(int id) => '$baseUrl/users/$id';


  static String userAddress(int id) => '$baseUrl/users/$id';
  static String userBank(int id) => '$baseUrl/users/$id';
  static String userCompany(int id) => '$baseUrl/users/$id';
  static String userFull(int id) => '$baseUrl/users/$id';


  static const String carts = '$baseUrl/carts';
  static String cartById(int id) => '$baseUrl/carts/$id';


  static const String todos = '$baseUrl/todos';
  static const String posts = '$baseUrl/posts';
}
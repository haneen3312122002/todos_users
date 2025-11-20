class AppEndpoints {
  //  Base URLs
  static const String baseUrl = 'https://dummyjson.com';
  static const String authBase = '$baseUrl/auth';

  //  Auth
  static const String login = '$authBase/login';
  static const String refreshToken = '$authBase/refresh';
  static const String getAuthUser = '$authBase/me';

  //  Users
  static const String getUsers = '$baseUrl/users';
  static String getUserById(int id) => '$baseUrl/users/$id';

  //  User details
  static String userAddress(int id) => '$baseUrl/users/$id';
  static String userBank(int id) => '$baseUrl/users/$id';
  static String userCompany(int id) => '$baseUrl/users/$id';
  static String userFull(int id) => '$baseUrl/users/$id';

  //  Carts
  static const String carts = '$baseUrl/carts';
  static String cartById(int id) => '$baseUrl/carts/$id';

  //  Tasks
  static const String todos = '$baseUrl/todos';
  static const String posts = '$baseUrl/posts';
}

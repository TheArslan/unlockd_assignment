// Api routes of app

class ApiURLConstants {
  // Base Url
  static const String baseUrl = "https://api.example.com/v1";
  // post api  route for login and get token
  static const String login = "$baseUrl/login";
  // get api route for fetch blogs
  static const String blogPosts = "$baseUrl/blog/posts";
  // post api route to logout user
  static const String logout = "$baseUrl/logout";
}

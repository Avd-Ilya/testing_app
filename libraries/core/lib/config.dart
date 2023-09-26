class Config {
  String baseUrl = 'http://localhost:5094';
  static RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
}
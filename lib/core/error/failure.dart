abstract class Failure implements Exception {
  String? title;
  String? message;

  Failure({
    this.title,
    this.message,
  });
}

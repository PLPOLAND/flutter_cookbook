class InfoException implements Exception {
  final String message;

  InfoException(this.message);

  @override
  String toString() {
    return message;
  }
}

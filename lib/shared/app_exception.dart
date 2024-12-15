class AppException implements Exception {
  static AppException from(dynamic exception) {
    if (exception is AppException) return exception;
    return UnknownException();
  }
}

class UnknownException extends AppException {}

class PostNotFoundException extends AppException {}

class PostCreateException extends AppException {}

class PostUpdateException extends AppException {}

class PostsLoadException extends AppException {}
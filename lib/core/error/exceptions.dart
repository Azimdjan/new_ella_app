class ServerException implements Exception {
  final String message;

  ServerException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class NoInternetException implements Exception {}

class CacheException implements Exception {}



class AppExceptions implements Exception{
  final String? message;
  final String? prefix;
  AppExceptions([this.message, this.prefix]);
  @override
  String toString(){
    return '$message$prefix';
  }
}

class InternetException extends AppExceptions{
  InternetException([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions{
  RequestTimeOut([String? message]) : super(message, '');
}

class ServerException extends AppExceptions{
  ServerException([String? message]) : super(message, '');
}

class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]) : super(message, 'Invalid Url');
}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]) : super(message, '');
}
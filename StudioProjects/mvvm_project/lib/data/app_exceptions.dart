class AppExcepion implements Exception{
  final _message;
  final _prefix;
  AppExcepion([this._message,this._prefix]);

  String toString(){
    return '$_message $_prefix';
  }
}

class FetchDataException extends AppExcepion{

  FetchDataException([String? message]):super(message,"Error during communication");
}

class BadRequestException extends AppExcepion{

  BadRequestException([String? message]):super(message,"Invalid request");
}

class UnauthorizedException extends AppExcepion{

  UnauthorizedException([String? message]):super(message,"Unauthorized request");

}

class InvalidInputException extends AppExcepion{

  InvalidInputException([String? message]):super(message,"Invalid input");
}
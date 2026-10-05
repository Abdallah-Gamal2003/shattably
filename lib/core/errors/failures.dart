
import 'package:dio/dio.dart';

abstract class Failure
{
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure{
  ServerFailure(String errorMessage) : super(errorMessage);
  factory ServerFailure.fromDioError(DioError dioError)
  {
    //Use switch with dioError
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection Timeout With API Server');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send Timeout With API Server');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive Timeout With API Server');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(dioError.response!.statusCode!, dioError.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request to API Server was  Canceled');
      case DioErrorType.unknown:
        //In case there is no internet
        if(dioError.message!.contains('SocketException'))
          {
            return ServerFailure('No Internet Connection');
          }
        return ServerFailure('Unexpected Error, Try Again!');
      default:
        return ServerFailure('Opps There was an Error, Try Later!');
    }
  }
  //To check type of error in response in API
  factory ServerFailure.fromResponse(int statusCode, dynamic response)
  {
    //400, 401, 403 request error
    if(statusCode == 400 || statusCode == 401 || statusCode == 403)
      {
        return ServerFailure(response['error']['message']);
      }
    else if(statusCode == 404 )
      {
        return ServerFailure('Your Request Not Found, Try Later!');
      }
    else if(statusCode == 500)
      {
        return ServerFailure('Internal Server Error, Try Later!');
      }
    else
      {
        return ServerFailure('Opps There was an Error, Try Later!');
      }
  }
}
import 'dart:async';
import 'package:retrofit/retrofit.dart';
import 'package:aquahome_app/services/api_service.dart';
import 'package:dio/dio.dart';

class RestHelper {
  static Future<bool> pingOfModule({String? ip, required String request}) async {
    if (ip == null) {
      return false;
    }
    var result = await ApiService(Dio(), ip)
        .turnControl(request)
        .catchError((e) => errorHandler(e));
    if (result.response.statusCode == 200) {
      return true;
    }
    return false;
  }
  static FutureOr<HttpResponse> errorHandler(dynamic error) {
    print('Возникла ошибка при post запросе: ${(error as DioError).response?.statusCode?? 0}');
    return HttpResponse(
        null,
        Response<dynamic>(
            requestOptions: RequestOptions(path: ''), statusCode: 500));
  }
}

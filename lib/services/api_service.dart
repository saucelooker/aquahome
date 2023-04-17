import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, String url) {
    dio.options = BaseOptions(
        baseUrl: "http://$url",
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: 'text/plain');
    return _ApiService(dio);
  }

  @POST("/turn")
  Future<HttpResponse> turnControl(@Query("data") String query);

  @POST("/intensity")
  Future<HttpResponse> intensityControl(@Query("data") String query);

  @POST("/color")
  Future<HttpResponse> colorControl(@Query("hue") String hue, @Query("sat") String sat);

  @POST("/mode")
  Future<HttpResponse> modeControl(@Query("data") String query);
}

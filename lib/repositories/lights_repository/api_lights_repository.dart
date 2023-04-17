import 'package:dio/dio.dart';
import '../../entities/light_control_entity.dart';
import '../../main_page/model/light_control_model.dart';
import 'i_lights_repository.dart';

class ApiLightsRepository implements ILightsRepository {
  final Dio dio;

  ApiLightsRepository({required this.dio});

  @override
  Future<bool> addNewLight(LightControlEntity light) async {
    // return await ApiService(dio)
    //     .addNewBook(name, author, totalPages)
    //     .catchError((error) => Helper.errorHandler(error));
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteLight(String id) async {
    // return await ApiService(dio)
    //     .deleteBook(id)
    //     .catchError((error) => Helper.errorHandler(error));
    throw UnimplementedError();
  }

  @override
  Future<List<LightControlEntity>> getAllLights() async {
    // return await ApiService(dio)
    //     .getAllBooks()
    //     .catchError((error) => Helper.errorHandler(error));
    throw UnimplementedError();
  }

  @override
  Future<bool> updateLight(LightControlEntity light) {
    throw UnimplementedError();
  }
}

import '../../entities/light_control_entity.dart';

abstract class ILightsRepository {
  Future<List<LightControlEntity>> getAllLights();

  Future<bool> addNewLight(LightControlEntity light);

  Future<bool> deleteLight(String id);

  Future<bool> updateLight(LightControlEntity light);
}

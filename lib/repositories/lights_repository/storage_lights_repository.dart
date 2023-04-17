import 'package:aquahome_app/entities/light_control_entity.dart';
import 'package:aquahome_app/main_page/model/light_control_model.dart';
import 'package:json_store/json_store.dart';

import 'i_lights_repository.dart';

class StorageLightsRepository implements ILightsRepository {
  final String _lightKey = 'light-';
  final JsonStore _storage = JsonStore(dbName: 'lights');

  @override
  Future<bool> addNewLight(LightControlEntity light) async {
    await _storage.setItem('$_lightKey${light.id}', light.toJson());
    return true;
  }

  @override
  Future<bool> deleteLight(String id) async {
    await _storage.deleteItem('$_lightKey$id');
    return true;
  }

  @override
  Future<List<LightControlEntity>> getAllLights() async {
    var jsonLights = await _storage.getListLike('$_lightKey%');
    List<LightControlEntity> lights = [];
    if (jsonLights != null) {
      lights =
          jsonLights.map((data) => LightControlEntity.fromJson(data)).toList();
    }
    return lights;
  }

  @override
  Future<bool> updateLight(LightControlEntity light) async {
    await _storage.setItem('$_lightKey${light.id}', light.toJson());
    return true;
  }
}

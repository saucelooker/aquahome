abstract class IGeneralDataRepository {
  Future<String?> getPassword();

  Future<bool> savePassword(String password);
}

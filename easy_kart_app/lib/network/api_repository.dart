abstract class ApiRepository {
  Future<Map<String, dynamic>> getMobileData(String endpoint);
  Future<Map<String, dynamic>> postMobileData(
      String endpoint, Map<String, dynamic> body);
  Future<Map<String, dynamic>> putMobileData(
      String endpoint, Map<String, dynamic> body);
}

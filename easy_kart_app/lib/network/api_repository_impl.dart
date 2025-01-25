import 'api_repository.dart';
import 'api_service.dart';

class ApiRepositoryImpl extends ApiRepository {
  final _apiService = ApiService.instance();

  @override
  Future<Map<String, dynamic>> getMobileData(String endpoint) async {
    return await _apiService.get(endpoint);
  }

  @override
  Future<Map<String, dynamic>> postMobileData(
      String endpoint, Map<String, dynamic> body) async {
    return await _apiService.post(endpoint, body);
  }

  @override
  Future<Map<String, dynamic>> putMobileData(
      String endpoint, Map<String, dynamic> body) async {
    return await _apiService.put(endpoint, body);
  }

  @override
  Future<Map<String, dynamic>> deleteMobileData(String endpoint) async {
    return await _apiService.delete(endpoint);
  }
}

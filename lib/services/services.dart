import 'package:reada/app/locator.dart';
import 'package:reada/services/api%20service/api.dart';
import 'package:reada/services/local_storage_service.dart';

class Services {
  static Api apiService = locator<Api>();
  static LocalStorageService localStorageService = LocalStorageService();
}

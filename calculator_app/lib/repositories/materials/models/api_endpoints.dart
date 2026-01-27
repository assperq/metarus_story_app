import 'dart:io';

class ApiEndpoints {
  ApiEndpoints._();
  static String baseUrl = getBaseUrl();
  static String materials = '${baseUrl}materials';
  static String types = '${baseUrl}materials/types';
  static String suppliers = '${baseUrl}suppliers';

  static String materialsById(int id) => '${baseUrl}materials/$id';
  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/'; // Android эмулятор
    } else if (Platform.isIOS) {
      return 'http://localhost:8000/'; // iOS симулятор
    } else {
      // Для реального устройства - нужен IP сервера в сети
      return 'http://127.0.0.1:8000/';
    }
  }
}

class ApiParameters {
  ApiParameters._();
  static const String search = 'name';
  static const String offset = 'offset';
  static const String limit = 'limit';
  static const String type = 'type_ids';
  static const String supplier = 'supplier_ids';
}

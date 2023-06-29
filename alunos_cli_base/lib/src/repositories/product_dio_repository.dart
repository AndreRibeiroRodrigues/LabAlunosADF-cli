import 'package:alunos_cli_base/src/models/course.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  Future<Course> findByName(String name) async {
    try {
      final response = await Dio().get('http://localhost:8080/products',
          queryParameters: {'name': name});
      if (response.data.isEmpty) {
        throw Exception();
      }

      return Course.fromMap(response.data.first);
    } on DioException {
      throw Exception();
    }
  }
}

import 'package:alunos_cli_base/src/models/student.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class StudentDioRepository {
  Future<List<Student>> findAll() async {
    // final studentsResult =
    //     await http.get(Uri.parse('http://localhost:8080/students'));
    // if (studentsResult.statusCode != 200) {
    //   throw Exception('Erro ao buscar alunos');
    // }

    try {
      final response = await Dio().get('http://localhost:8080/students');
      // final studentData = jsonDecode(studentsResult.body);

      return response.data.map<Student>((student) {
        return Student.fromMap(student);
      }).toList();
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Student> findById(int id) async {
    try {
      final studentResult = await Dio()
          .get("http://localhost:8080/students", queryParameters: {"id": id});

      if (studentResult.data == null) {
        throw Exception();
      }

      return Student.fromMap(studentResult.data);
    } on DioException catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> insert(Student student) async {
    final response = await http.post(
        Uri.parse("http://localhost:8080/students"),
        body: student.toJson(),
        headers: {"content-type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Erro ao inserir o Aluno');
    }
  }

  Future<void> update(Student student) async {
    final response = await http.put(
        Uri.parse("http://localhost:8080/students/${student.id}"),
        body: student.toJson(),
        headers: {"content-type": "application/json"});

    if (response.statusCode != 200) {
      throw Exception('Erro ao Alterar o Aluno');
    }
  }

  Future<void> deleteById(int id) async {
    final response =
        await http.delete(Uri.parse("http://localhost:8080/students/${id}"));
    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar o Aluno');
    }
  }
}

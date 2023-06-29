import 'dart:convert';


import 'package:alunos_cli_base/src/models/student.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  Future<List<Student>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));
    if (studentsResult.statusCode != 200) {
      throw Exception('Erro ao buscar alunos');
    }

    final studentData = jsonDecode(studentsResult.body);

    return studentData.map<Student>((student) {
      return Student.fromMap(student);
    }).toList();
  }

  Future<Student> findById(int id) async {
    final studentResult =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));
    if (studentResult.statusCode != 200) {
      throw Exception('Erro ao buscar aluno');
    }
    if (studentResult.body == '{}') {
      throw Exception('Usuario não existe');
    }

    return Student.fromJson(studentResult.body);
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

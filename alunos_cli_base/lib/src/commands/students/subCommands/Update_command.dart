// ignore: file_names
// ignore: file_names
import 'dart:io';

import 'package:alunos_cli_base/src/models/address.dart';
import 'package:alunos_cli_base/src/models/city.dart';
import 'package:alunos_cli_base/src/models/phone.dart';
import 'package:alunos_cli_base/src/models/student.dart';
import 'package:alunos_cli_base/src/repositories/product_repository.dart';
import 'package:alunos_cli_base/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';


class UpdateCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository = ProductRepository();
  @override
  String get description => 'Update student';

  @override
  String get name => 'update';
  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    print('Aguarde ...');
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informe o id do aluno com o commando --id=0 ou -i 0');
      return;
    }

    final students = File(filePath).readAsLinesSync();
    print('Aguarde, atualizando os dados do aluno...');
    print('-------------------------------------------');

    if (students.length > 1) {
      print('Por favor informe somente um aluno no arquivo $filePath');
      return;
    } else if (students.isEmpty) {
      print('Por favor informe um aluno no arquivo $filePath');
      return;
    }

    var student = students.first;

      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      final courseFuture = courseCsv.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(courseFuture);

      
      final studentModel = Student(
        id: int.parse(id),
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: courseCsv,
        courses: courses,
        address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
        ),
      );
      await studentRepository.update(studentModel);
    print('--------------------------------------');
    print('Aluno atualizado com Sucesso');
  }
}

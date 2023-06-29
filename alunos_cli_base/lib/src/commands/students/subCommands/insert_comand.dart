import 'dart:io';

import 'package:alunos_cli_base/src/models/address.dart';
import 'package:alunos_cli_base/src/models/city.dart';
import 'package:alunos_cli_base/src/models/phone.dart';
import 'package:alunos_cli_base/src/models/student.dart';
import 'package:alunos_cli_base/src/repositories/product_repository.dart';
import 'package:alunos_cli_base/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final ProductRepository productRepository = ProductRepository();

  @override
  String get description => 'insert Students';

  @override
  String get name => 'insert';
  InsertCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the csv file', abbr: 'f');
  }
  @override
  Future<void> run() async {
    print('Aguarde ...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('-------------------------------------------');

    for (var student in students) {
      print('Aguarde...');
      final studentData = student.split(';');
      final courseCsv = studentData[2].split(',').map((e) => e.trim()).toList();

      final courseFuture = courseCsv.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        print(course);
        return course;
      }).toList();

      final courses = await Future.wait(courseFuture);

      print('test');
      final studentModel = Student(
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
      await studentRepository.insert(studentModel);
    }
      print('--------------------------------------');
      print('Alunos adicionados com Sucesso');
  }
}

import 'dart:io';

import 'package:alunos_cli_base/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';

class DeleteCommand extends Command {
  final StudentRepository studentRepository;
  @override
  String get description => 'Delete the Student from id';

  @override
  String get name => 'delete';

  DeleteCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  Future<void> run() async {
    final id = argResults?['id'];

    if (id == null) {
      print('Por favor informe o id utilizando --id=0 ou -i 0');
      return;
    }

    final student = await studentRepository.findById(int.parse(id));
    print('-------------------------------------');
    print('Aluno: ${student.name}');
    print('-------------------------------------');
    print('Name: ${student.name}');
    print('Ideda: ${student.age ?? 'Não Informado'}');
    print('Curso:');
    student.nameCourses.forEach(print);
    print('Enedereço:');
    print('   ${student.address.street} - ${student.address.zipCode}');

    print('Deseja deleter este aluno? (s/n)');

    final resposta = stdin.readLineSync();

    if (resposta?.toLowerCase() == 's') {
      await studentRepository.deleteById(int.parse(id));
      print('Estudante deletedo com sucesso');
    } else {
      return;
    }
  }
}

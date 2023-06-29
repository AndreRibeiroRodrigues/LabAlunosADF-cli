import 'package:alunos_cli_base/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';


class FindByIdCommand extends Command {
  final StudentRepository studentRepository;
  

  @override
  String get description => "find Student by id";

  @override
  String get name => "byId";

  FindByIdCommand(this.studentRepository) {
    argParser.addOption('id', help: "Student id", abbr: 'i');
  }

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print("por favor envie o id do aluno com o comando --id=0 ou -i 0");
      return;
    }

    final id = int.tryParse(argResults?['id']);

    print('Aguarde buscando dados...');

    final student = await studentRepository.findById(id!);
    print('-------------------------------------');
    print('Aluno: ${student.name}');
    print('-------------------------------------');
    print('Name: ${student.name}');
    print('Ideda: ${student.age?? 'Não Informado'}');
    print('Curso:');
    student.nameCourses.forEach(print);
    print('Enedereço:');
    print('   ${student.address.street} - ${student.address.zipCode}');
  }
}

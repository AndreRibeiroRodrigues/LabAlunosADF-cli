import 'package:alunos_cli_base/src/commands/students/students_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> args) {
  // final argsParcer = ArgParser();
  // argsParcer.addFlag('data', abbr: 'd');
  // argsParcer.addOption('name', abbr: 'n');
  // argsParcer.addOption('template', abbr: 't');
  // final argResult = argsParcer.parse(args);

  // print('${argResult['data']}');
  // print('${argResult['name']}');
  // print('${argResult['template']}');

  CommandRunner('ADF CLI', 'ADF CLI')
    ..addCommand(StudentsCommand())
    ..run(args);
}


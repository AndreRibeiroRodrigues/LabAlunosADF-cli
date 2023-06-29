import 'package:alunos_cli_base/src/commands/students/subCommands/delete_command.dart';
import 'package:alunos_cli_base/src/commands/students/subCommands/Update_command.dart';
import 'package:alunos_cli_base/src/commands/students/subCommands/find_all_command.dart';
import 'package:alunos_cli_base/src/commands/students/subCommands/find_by_id_command.dart';
import 'package:alunos_cli_base/src/commands/students/subCommands/insert_comand.dart';
import 'package:alunos_cli_base/src/repositories/student_repository.dart';
import 'package:args/command_runner.dart';

class StudentsCommand extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';

  StudentsCommand() {
    final studentRepository = StudentRepository();
    addSubcommand(FindAllCommand(studentRepository));
    addSubcommand(FindByIdCommand(studentRepository));
    addSubcommand(InsertCommand(studentRepository));
    addSubcommand(UpdateCommand(studentRepository));
    addSubcommand(DeleteCommand(studentRepository));
  }
}

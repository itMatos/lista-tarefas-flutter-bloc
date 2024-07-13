import 'package:aula_bloc/app/data/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll([
      TarefaModel(nome: 'Estudar Flutter'),
      TarefaModel(nome: 'Estudar Dart'),
      TarefaModel(nome: 'Estudar Bloc'),
    ]);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  Future<List<TarefaModel>> addTarefa({required TarefaModel tarefa}) async {
    _tarefas.add(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  Future<List<TarefaModel>> removeTarefa({required TarefaModel tarefa}) async {
    _tarefas.remove(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }
}

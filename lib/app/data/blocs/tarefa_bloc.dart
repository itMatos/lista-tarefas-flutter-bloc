import 'dart:async';
import 'package:aula_bloc/app/data/blocs/tarefa_event.dart';
import 'package:aula_bloc/app/data/blocs/tarefa_state.dart';
import 'package:aula_bloc/app/data/repositories/tarefa_repository.dart';
import 'package:aula_bloc/app/data/models/tarefa_model.dart';
import 'package:bloc/bloc.dart';

class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
  final _repository = TarefaRepository();
  final _inputTarefaController = StreamController<TarefaEvent>();
  final _outputTarefaController = StreamController<TarefaState>();

  Sink<TarefaEvent> get inputTarefa => _inputTarefaController.sink;
  Stream<TarefaState> get outputTarefa => _outputTarefaController.stream;

  TarefaBloc() : super(TarefaInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(TarefaEvent event, Emitter emit) async {
    List<TarefaModel> tarefas = [];

    /// todo evento que for emitido pelo listen, já deve disparar um loading
    /// para que o usuário saiba que algo está acontecendo
    // _outputTarefaController.sink.add(TarefaLoadingState());
    emit(TarefaLoadingState());

    /// em seguida, devemos verificar qual evento de fato causou o loading
    if (event is GetTarefas) {
      tarefas = await _repository.getTarefas();
    } else if (event is PostTarefa) {
      tarefas = await _repository.addTarefa(tarefa: event.tarefa);
    } else if (event is DeleteTarefa) {
      tarefas = await _repository.removeTarefa(tarefa: event.tarefa);
    }
    // _outputTarefaController.add(event is GetTarefas
    //     ? TarefaLoadedState(tarefas: tarefas)
    //     : TarefaLoadedState(tarefas: tarefas));
    emit(TarefaLoadedState(tarefas: tarefas));
  }
}

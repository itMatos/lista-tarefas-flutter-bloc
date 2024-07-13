import 'package:aula_bloc/app/data/blocs/tarefa_bloc.dart';
import 'package:aula_bloc/app/data/blocs/tarefa_event.dart';
import 'package:aula_bloc/app/data/blocs/tarefa_state.dart';
import 'package:aula_bloc/app/data/models/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late TarefaBloc _tarefaBloc;

  @override
  void initState() {
    super.initState();
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      // BlocBuilder pode ser equivalente ao streamBuilder
      body: BlocBuilder<TarefaBloc, TarefaState>(
          bloc: _tarefaBloc,
          builder: (context, state) {
            if (state is TarefaLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TarefaLoadedState) {
              final tarefaList = state.tarefas;
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: tarefaList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: CircleAvatar(
                        child: Center(
                          child: Text(
                            tarefaList[index].nome[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(tarefaList[index].nome),
                      trailing: IconButton(
                        onPressed: () {
                          _tarefaBloc
                              .add(DeleteTarefa(tarefa: tarefaList[index]));
                        },
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                      ));
                },
              );
            } else {
              return const Center(
                child: Text('Erro ao carregar tarefas'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _tarefaBloc.add(PostTarefa(
            tarefa: TarefaModel(nome: 'Nova tarefa'),
          ));
        },
      ),
    );
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }
}

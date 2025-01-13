import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:todolist_provider/provider/todos_provider.dart';
import 'package:todolist_provider/provider/login_provider.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  late List<Todos> todosList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList (Provider)'),
        leading: IconButton(
          onPressed: () {
            context.read<LoginProvider>().logout(context);
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) {
          todosList = provider.getTodosList();
          return StreamBuilder<List<Todos>>(
            stream: provider.todosStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 데이터가 로드 중인지 확인
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (snapshot.hasError) {
                // 에러가 있는지 확인
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                // 데이터가 없는지 확인
                return const Center(child: Text('No todos available'));
              }
              return ListView.builder(
                itemCount: todosList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Text(todosList[index].id.toString()),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todosList[index].title!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  "userId : ${todosList[index].userId.toString()}"),
                            ],
                          ),
                        ),
                        Checkbox(
                          value: todosList[index].completed,
                          onChanged: null,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

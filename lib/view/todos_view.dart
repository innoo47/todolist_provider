import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_provider/model/todos.dart';
import 'package:todolist_provider/provider/todos_provider.dart';

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
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) {
          todosList = provider.getTodosList();
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
                      value: todosList[index].completed.toString() == 'true'
                          ? true
                          : false,
                      onChanged: null,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
  @override
  void initState() {
    super.initState();
    Provider.of<TodosProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList (Provider)'),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, provider, child) {
          return StreamBuilder<List<Todos>>(
              stream: provider.todosStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data'));
                }
                final todosList = snapshot.data!;
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
              });
        },
      ),
    );
  }
}

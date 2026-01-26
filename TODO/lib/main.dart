import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';
import 'notifier.dart';
import 'widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: ChangeNotifierProvider(
        create: (_) => TodoListNotifier(),
        child: const MyHomePage(),
      ),
    );
  }
}

.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TodoListNotifier>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Column(
            children: [
              for (int i = 0; i < notifier.length; i++)
                TodoItem(todo: notifier.getTodo(i))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => notifier.addTodo('Nuovo Todo'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

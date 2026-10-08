import 'package:flutter/material.dart';

import 'models/task.dart';
import 'screens/add_task_screen.dart';

void main() {
  runApp(const TodoApp());
}

/// Root widget of the to-do application.
class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}

/// The main screen with the list of tasks and a button to add new ones.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];

  Future<void> _addTask() async {
    final task = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (task != null) {
      setState(() => _tasks.add(task));
    }
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мои задачи')),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'Задач пока нет.\nНажмите «+», чтобы добавить первую.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              key: const Key('task_list'),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Dismissible(
                  key: Key('task_$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red.shade100,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (_) => _removeTask(index),
                  child: ListTile(
                    leading: Checkbox(
                      key: Key('task_checkbox_$index'),
                      value: task.isDone,
                      onChanged: (_) => _toggleTask(index),
                    ),
                    title: Text(
                      task.title,
                      style: task.isDone
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,)
                          : null,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add_task_button'),
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

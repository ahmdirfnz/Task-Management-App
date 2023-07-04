import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Task Management App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todos = <Todo>[];
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _displayDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a todo'),
            content: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'Add your task'),
              autofocus: true,
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                  onPressed: () {
                  Navigator.of(context).pop();
                  }, 
                  child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),
                  onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textEditingController.text);
                  }, 
                  child: const Text('Add')
              ),
            ],
          );
        }
    );
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, completed: false));
      _textEditingController.clear();
    });
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.name == todo.name);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
            removeTodo: _deleteTodo,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Todo {
  Todo({required this.name, required this.completed});
  String name;
  bool completed;
}

class TodoItem extends StatelessWidget {
  var removeTodo;

  TodoItem({required this.todo, required this.onTodoChanged, required this.removeTodo}) : super(key: ObjectKey(todo));

  final Todo todo;

  final void Function(Todo todo) onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.white,
          activeColor: Colors.green,
          value: todo.completed,
          onChanged: (value) {
          onTodoChanged(todo);
          },
      ),
      title: Row(
        children: [
          Expanded(
              child: Text(todo.name, style: _getTextStyle(todo.completed)),
          ),
          IconButton(
              onPressed: (){
                removeTodo(todo);
              },
              iconSize: 30,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}


class BlueBox extends StatelessWidget {
  const BlueBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all()
      ),
    );
  }
}




import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo something'),
      ),
      body: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var item = TextEditingController();
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  obscureText: true,
                  controller: item,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    label: Text('Add todo item'),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                    height: 58,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.add(item.text);
                            item.clear();
                          });
                        },
                        child: const Text('Add'))),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (_, index) {
              return Dismissible(
                key: Key(items[index]),
                onDismissed: (_) {
                  setState(() {
                    items.removeAt(index);
                  });
                },
                direction: DismissDirection.endToStart,
                background: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    color: Colors.red,
                  ),
                ),
                child: Item(items[index], index + 1),
              );
            },
            itemCount: items.length,
          )),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  const Item(this.title, this.index, {super.key});
  final int index;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          child: Text('$index'),
        ),
        title: Text(title),
        trailing: Icon(Icons.delete),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = new TextEditingController();

  List<String> tasks = [];

  void _addTasks() {
    _taskController.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add a task"),
            content: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    tasks.add(_taskController.text);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("Add"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          "To Do List",
          style: TextStyle(color: Colors.white70),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTasks();
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                     Checkbox(value: false, onChanged: (value){

                     }),
                      Text(
                        tasks[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              tasks.remove(tasks[index]);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.deepOrangeAccent,
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

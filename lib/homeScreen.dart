import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/auth/authService.dart';
import 'package:todolist/auth/loginScreen.dart';
import 'package:todolist/task.dart';
import 'package:todolist/taskProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = AuthService();
  final GlobalKey<FormState> _taskFormKey = GlobalKey<FormState>();
  final TextEditingController _taskController = new TextEditingController();

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  void _addTasks() {
    _taskController.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Add a task",
            ),
            content: Form(
              key: _taskFormKey,
              child: TextFormField(
                controller: _taskController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter task";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Task",
                  labelStyle: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 10, color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 2, color: Colors.blueAccent)),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.blueAccent),
                  )),
              TextButton(
                  onPressed: () {
                    if (_taskFormKey.currentState!.validate()) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(_taskController.text);
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Text("Add", style: TextStyle(color: Colors.blueAccent)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "To - Do",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _addTasks,
              icon: Icon(Icons.add, color: Colors.white70))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _auth.signout();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Loginscreen()));
        },
        child: Icon(
          Icons.logout_rounded,
          color: Colors.white70,
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TaskProvider>(
            builder: (BuildContext context, taskProvider, Widget? child) {
          final tasks = taskProvider.tasks;
          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.white70,
                            checkColor: Colors.blueAccent,
                            value: task.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                task.isCompleted = value!;
                              });
                              taskProvider.updateTask(
                                  task.id, task.title, task.isCompleted);
                            }),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text(
                            task.title,
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              taskProvider.deleteTask(task.id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white70,
                            ))
                      ],
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}

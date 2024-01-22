import 'package:flutter/material.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> todos = [
    {'taskName': 'Meditate', 'isCompleted': true},
    {'taskName': 'Read for 15 minutes', 'isCompleted': false}
  ];

  // Handle Checkbox toggle.
  void toggleCheckedBox(bool? value, int index) {
    setState(() {
      todos[index]['isCompleted'] = !(todos[index]['isCompleted'] ?? false);
    });
  }

  void saveNewTask() {
    String userInput =
        _controller.text.trim(); // Remove leading and trailing whitespaces

    if (userInput.isNotEmpty) {
      setState(() {
        // Add a new map to the 'todos' list
        todos.add({
          'taskName': userInput,
          'isCompleted': false,
        });
      });

      Navigator.of(context).pop(); // Close the dialog
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(color: Color.fromARGB(255, 255, 39, 23)),
            ),
            content: const Text('Task name cannot be empty!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the AlertDialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF48426D);
    const Color appBarBackgroundColor = Color(0x4E626262);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'TO DO',
            style: TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: appBarBackgroundColor,
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todos[index]['taskName'],
            isCompleted: todos[index]['isCompleted'],
            onChanged: (value) => toggleCheckedBox(value, index),
          );
        },
      ),
    );
  }
}

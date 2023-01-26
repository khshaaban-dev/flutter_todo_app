import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/database.dart';
import 'package:flutter_todo_app/widgets/dailog_box.dart';
import 'package:flutter_todo_app/widgets/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final db = Database();
  final _mybox = Hive.box(Database.boxName);

  @override
  void initState() {
    if (_mybox.get(Database.collectinName) == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void onChanged(bool? newValue, int index) {
    setState(() {
      db.listOfTodos.elementAt(index)['isCompleted'] = newValue;
    });
    if (kDebugMode) {
      print(db.listOfTodos);
    }
    db.updatTodos();
  }

  void showCustomDailog() {
    showDialog(
      context: context,
      builder: (context) => DailogBox(
        controller: controller,
        onSave: onSave,
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void onSave() {
    final String taskName = controller.text;
    if (taskName.isNotEmpty) {
      setState(() {
        db.listOfTodos.add(
          {
            "title": taskName,
            "isCompleted": false,
          },
        );
      });

      controller.clear();
      Navigator.pop(context);
      db.updatTodos();
    }
  }

  void deleteTask(int index) {
    setState(() {
      db.listOfTodos.removeAt(index);
    });
    db.updatTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text(
          'To Do',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.listOfTodos.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            todoName: db.listOfTodos[index]['title'],
            isCompleted: db.listOfTodos[index]['isCompleted'],
            onChanged: (newValue) => onChanged(newValue, index),
            onDelete: (context) => deleteTask(
              index,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCustomDailog,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

import 'package:hive_flutter/adapters.dart';

class Database {
  // hive box name
  static const String boxName = 'myBox';
  static const String collectinName = 'todos';

  // ref to hive box
  final _myBox = Hive.box(boxName);

  //list of todos
  List listOfTodos = [];

  // inital data
  void initialData() {
    listOfTodos = [
      {"title": 'Make Tutorail', "isCompleted": true},
      {"title": 'Do Excrses', "isCompleted": true},
    ];
  }

  // load data from database
  void loadData() {
    listOfTodos = _myBox.get(collectinName);
  }

  // add new  todo

  // update todo
  void updatTodos() {
    _myBox.put(collectinName, listOfTodos);
  }
  //delete todo
}

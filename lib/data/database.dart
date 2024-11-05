import 'package:hive/hive.dart';

class ToDoDataBase{

  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  //run the method if this is the first time ever opening this app
  void createInitialData()
  {
    toDoList = [
      ['Learn Flutter', false]
    ];

  }

  //load the data from database
  void loadData()
  {
    toDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDataBase()
  {
    _myBox.put("TODOLIST", toDoList);
  }

}
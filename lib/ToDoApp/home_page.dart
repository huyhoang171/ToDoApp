import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:testflutter/ToDoApp/todo_tile.dart';
import 'package:testflutter/data/database.dart';

import 'dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //reference the hive box
  final _myBox = Hive.box('mybox');

  //controller text field
  final _controller = TextEditingController();

  //database
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the 1st time ever opening the app, then create default data
    if( _myBox.get("TODOLIST") == null)
      {
        db.createInitialData();
      }
    else
      {
        //there already exists data
        db.loadData();
      }

    super.initState();
  }

  void checkBoxChanged(bool? value ,int index)
  {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask()
  {
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();

  }

  void createNewTask()
  {
    showDialog(
      context: context,
      builder: (context){
         return DialogBox(
           controller: _controller,
           onCancel: () => Navigator.of(context).pop(),
           onSave: saveNewTask,
         );
      },
    );
  }
  
  void deleteTask(int index)
  {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        title: const Center(
          child: Text(
            'TO DO',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child:  Icon(Icons.add),
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value){
                checkBoxChanged(value, index);
              },
              deleteFunction: (context) => deleteTask(index),
              );
        },

      ),
    );
  }
}

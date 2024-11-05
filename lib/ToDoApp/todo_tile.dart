import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String _taskName;
  final bool _taskCompleted;
  final Function(bool?)? _onChanged;
  final Function(BuildContext)? deleteFunction;

  const TodoTile(
      {
        super.key,
        required String taskName,
        required bool taskCompleted,
        required Function(bool?)? onChanged,
        required this.deleteFunction,
      })
      : _taskName = taskName,
        _taskCompleted = taskCompleted,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Slidable(
        endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(12),
              )
            ]
        ),
        child: Container(
          padding: const EdgeInsets.all(22.0),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              //checkbox
              Checkbox(
                value: _taskCompleted,
                onChanged: _onChanged,
                activeColor: Colors.black,
        
              ),
        
              //task name
              Text(
                _taskName,
                style: TextStyle(
                  decoration:
                    _taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

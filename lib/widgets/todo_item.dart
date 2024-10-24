import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';

class TodoItem extends StatelessWidget {
    final ToDo todo;
    // ignore: prefer_typing_uninitialized_variables
    final onTodoChanged;
    final onDelete;

  const TodoItem({super.key, required this.todo, required this.onTodoChanged, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone? Icons.check_box:Icons.check_box_outline_blank, 
          color: tdBlue
          ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todo.isDone? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          // padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 8),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdred,
            borderRadius: BorderRadius.circular(5)
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon:Icon(Icons.delete),
            onPressed: (){
              print('clicked');
              onDelete(todo.id);
            },
            ),
        ),
      ),
    );
  }
}

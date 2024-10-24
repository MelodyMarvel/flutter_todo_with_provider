import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';

class ToDoProvider with ChangeNotifier {
    final _todoController = TextEditingController();

  List<ToDo> todosList = ToDo.todoList();

  List<ToDo> get _todosList => todosList;

  List<ToDo> _foundTodo = [];

  List<ToDo> get foundTodo => _foundTodo.isEmpty ? _todosList : _foundTodo;

  ToDoProvider() {
    _foundTodo = _todosList;
  }

  void toggleTodoStatus(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners(); // Notifies listeners about the change
  }

  void deleteTodoById(String id) {
    _todosList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addTodoItem(String toDo) {
    _todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo));
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _foundTodo = _todosList;
    } else {
      _foundTodo = _todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

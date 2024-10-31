import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/services/todo_services.dart';
import 'package:http/http.dart';

class ToDoProvider with ChangeNotifier {
  final TodoService _service;
  bool isLoading = false;

  final _todoController = TextEditingController();

  List<ToDo> todosList = [];

  List<ToDo> get _todosList => todosList;

  List<ToDo> _foundTodo = [];

  List<ToDo> get foundTodo => _foundTodo.isEmpty ? _todosList : _foundTodo;
  // List<ToDo> get foundTodo => _foundTodo;

  ToDoProvider({required TodoService service}) : _service = service {
    _foundTodo = _todosList;
  }

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.getAll();
      todosList = response;
      _foundTodo = response;
    } catch (e) {
      // Handle error (log it, show message, etc.)
      debugPrint('Error fetching todos: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleTodoStatus(ToDo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void deleteTodoById(String id) {
    _todosList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void addTodoItem(String toDo) {
    _todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
    notifyListeners();
  }

  void runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _foundTodo = _todosList;
    } else {
      _foundTodo = _todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

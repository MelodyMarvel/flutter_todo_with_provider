import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_todo_app/model/todo.dart';

class TodoService {
  Future<List<ToDo>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    final uri =  Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List;
      final todos = json.map((e) {
        return ToDo(
          id: e['id'].toString(),
          todoText: e['title'],
          isDone: e['completed']
          );
      }
      ).toList();
      return todos;
    }
    return [];
  }
}
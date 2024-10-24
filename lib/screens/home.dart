// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/widgets/todo_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_todo_app/provider/todo_provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  // List<ToDo> _foundTodo = [];

  // void initState() {
  //   _foundTodo = todosList;
  //   super.initState();
  // }

  // void _handleTodoChange(ToDo todo) {
  //   // ignore: unused_element
  //   setState(() {
  //     todo.isDone = !todo.isDone;
  //   });
  // }

  // void _handleDelete(String id) {
  //   setState(() {
  //     todosList.removeWhere((item) => item.id == id);
  //   });
  // }

  // void _addTodoItem(String toDo) {
  //   setState(() {
  //     todosList.add(ToDo(
  //         id: DateTime.now().millisecondsSinceEpoch.toString(),
  //         todoText: toDo));
  //   });
  //   _todoController.clear();
  // }

  // void _runFilter(String enteredKeyword) {
  //   List<ToDo> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     results = todosList;
  //   } else {
  //     results = todosList
  //         .where((item) => item.todoText!
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //   }

  //   setState(() {
  //     _foundTodo = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(builder: (context, value, child){
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (ToDo todo in value.foundTodo.reversed)
                          TodoItem(
                            todo: todo,
                            onTodoChanged: value.toggleTodoStatus,
                            onDelete: value.deleteTodoById,
                          ),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0)
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      value.addTodoItem(_todoController.text);
                      _todoController.clear();
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    }
    
    );
    
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/profile.png')),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => 
        Provider.of<ToDoProvider>(context, listen: false).runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
            border: InputBorder.none,
            prefixIconConstraints: BoxConstraints(minHeight: 20, minWidth: 25)),
      ),
    );
  }
}

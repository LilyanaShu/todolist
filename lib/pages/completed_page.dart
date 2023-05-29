import 'package:flutter/material.dart';
import 'package:todolist/model/todo_item.dart';
import 'package:todolist/utils/network_manager.dart';

import '../utils/get_color.dart';
import '../utils/get_todo.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;

  void refreshData(){
    NetworkManager().getTodoisDone(true).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetColor().primary,
      appBar: AppBar(
        //backgroundColor: GetColor().secondary,
        title: const Text("Completed Todo List"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            isLoading? const Center(child: CircularProgressIndicator(),) :
            Expanded(child: todos.isEmpty ? const Center(child: Text("No Completed List")) :
            ListView.builder(
              itemBuilder: (context, index) {
                return GetTodo(todoItem: todos[index], handleRefresh: refreshData,);
              },
              itemCount: todos.length ,
            )
            ),
          ],
        ),

      ),
    );

  }
}

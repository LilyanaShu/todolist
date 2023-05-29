import 'package:flutter/material.dart';
import 'package:todolist/pages/addtodo_page.dart';
import 'package:todolist/pages/completed_page.dart';
import 'package:todolist/utils/get_color.dart';
import 'package:todolist/utils/get_todo.dart';
import 'package:todolist/utils/network_manager.dart';

import '../model/todo_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];
  bool isLoading = false;
  int totalDone = 0;

  void refreshData(){
    setState(() {
      isLoading = true;
    });
    NetworkManager().getTodoisDone(true).then((value) {
      totalDone = value.length;
      setState(() {});
    });
    NetworkManager().getTodoisDone(false).then((value) {
      todos = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
   // final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: GetColor().primary,
      appBar: AppBar(
        //backgroundColor: GetColor().secondary,
        title: const Text("Todo List"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Pending"),
                InkWell(
                  onTap: (){},
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CompletedPage();
                      }));
                    },
                      child: const Text("Show Completed")),
                )
              ],
            ),
            const SizedBox(height: 10,),
            isLoading? const Center(child: CircularProgressIndicator(),) :
            Expanded(child: todos.isEmpty ? const Center(child: Text("No list available")) :
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodo())
          );
          refreshData();

        },
        backgroundColor: GetColor().secondary,
        child: const Icon(Icons.add_outlined, color: Colors.white, size: 36,),
      ),
    );
  }
}

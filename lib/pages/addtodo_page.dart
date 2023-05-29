
import 'package:flutter/material.dart';
import 'package:todolist/model/todo_item.dart';
import 'package:todolist/utils/network_manager.dart';
import '../utils/get_color.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  void saveDate() async{
    //final result = await
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final descController = TextEditingController();
   // final

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Add new todo"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height/2.5,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: GetColor().quaternary,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text("Entry below"),
              SizedBox(
                //height: 200,
                width: 300,
                child: TextFormField(
                  controller: descController,
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please entry todo";
                    }
                    return null;
                  },
                  autofocus: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Add Todo"
                  ),
                  //autofocus: true,
                )
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GetColor().primary,
                          foregroundColor: GetColor().tertiary
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back, size: 16,),
                          Text(" Back ", style: TextStyle(fontSize: 16),),
                        ],
                      ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _formKey.currentState!.validate();
                      final item = TodoItem(title: 'task',
                          description: descController.text,
                          isDone: false
                      );
                      if(descController.text.isNotEmpty){
                        await NetworkManager().postData(item);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GetColor().primary,
                        foregroundColor: GetColor().secondary
                    ),
                    child: Row(
                      children: [
                        Text("Save ", style: TextStyle(fontSize: 16),),
                        const Icon(Icons.save_outlined, size: 16,),
                      ],
                    ),
                  ),
                ],
              ),
          ],
      ),
        )
      )
    );
  }
}

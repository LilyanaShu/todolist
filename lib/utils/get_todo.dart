import 'package:flutter/material.dart';
import 'package:todolist/model/todo_item.dart';
import 'package:todolist/utils/get_color.dart';
import 'package:todolist/utils/network_manager.dart';

class GetTodo extends StatelessWidget {
  const GetTodo({Key? key, required this.todoItem, required this.handleRefresh}) : super(key: key);
  final TodoItem todoItem;
  final Function handleRefresh;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todoItem.isDone ? Colors.grey.shade300 : GetColor().quaternary,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Expanded(child: Text(todoItem.title), flex: 1,),
            //SizedBox(width: 10,),
            Expanded(child: Text(todoItem.description)),
            Row(
              children: [
                if(!todoItem.isDone)
                  ElevatedButton(
                      onPressed: () async {
                        await NetworkManager().updateData(
                          todoItem.copyWith(isDone: true)
                        );
                        handleRefresh();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GetColor().primary,
                          foregroundColor: GetColor().secondary
                      ),
                      child: const Icon(Icons.done)
                  ),
                const SizedBox(width: 5,),

                if(!todoItem.isDone)
                  ElevatedButton(
                      onPressed: () async {
                        await NetworkManager().deleteData(todoItem);
                        handleRefresh();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GetColor().primary,
                          foregroundColor: GetColor().tertiary,

                      ),
                      child: const Icon(Icons.remove)
                  ),
              ],
            )
          ],
          
        ),
      ),
    );
  }
}

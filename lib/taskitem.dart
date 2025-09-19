import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'mystate.dart';

Widget taskItem(BuildContext context, Task task) {
  final done = task.isDone;
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            IconButton(
              icon: Icon(
                done ? Icons.check_box : Icons.check_box_outline_blank,
                color: done ? Colors.green : null,
              ),
              onPressed: () {
                context.read<MyState>().toggleTask(task);
              },
            ),
            Text(
              task.title,
              style: TextStyle(
                decoration: done ? TextDecoration.lineThrough :null,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete), 
              onPressed: () {
                context.read<MyState>().removeTask(task);
              },
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey),
    ],
  );
}
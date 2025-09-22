import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mystate.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add task page'),
      centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Write new todo here'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<MyState>().addTask(_controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add task"),
            ),
          ],
        ),
      ),
    );
  }
}
